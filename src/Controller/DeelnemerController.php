<?php

namespace App\Controller;

use App\Form\Ww_wijzigenType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class DeelnemerController extends AbstractController {
    /**
     * @Route("/user/activiteiten", name="activiteiten")
     */
    public function activiteitenAction() {
        $user = $this->get('security.token_storage')->getToken()->getUser();

        $beschikbareActiviteiten = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->getBeschikbareActiviteiten($user->getId());

        $ingeschrevenActiviteiten = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->getIngeschrevenActiviteiten($user->getId());

        $totaal = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->getTotaal($ingeschrevenActiviteiten);

        return $this->render('deelnemer/activiteiten.html.twig', [
            'beschikbare_activiteiten' => $beschikbareActiviteiten,
            'ingeschreven_activiteiten' => $ingeschrevenActiviteiten,
            'totaal' => $totaal,
        ]);
    }

    /**
     * @Route("/user/inschrijven/{id}", name="inschrijven")
     */
    public function inschrijvenActiviteitAction($id) {
        $activiteit = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->find($id);
        $user = $this->get('security.token_storage')->getToken()->getUser();
        $user->addActiviteit($activiteit);

        $em = $this->getDoctrine()->getManager();
        $em->persist($user);
        $em->flush();

        return $this->redirectToRoute('activiteiten');
    }

    /**
     * @Route("/user/uitschrijven/{id}", name="uitschrijven")
     */
    public function uitschrijvenActiviteitAction($id) {
        $activiteit = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->find($id);
        $user = $this->get('security.token_storage')->getToken()->getUser();
        $user->removeActiviteit($activiteit);

        $em = $this->getDoctrine()->getManager();
        $em->persist($user);
        $em->flush();

        return $this->redirectToRoute('activiteiten');
    }

    /**
     * @Route("/user/profiel", name="profiel")
     */
    public function profielAction() {
        return $this->render('deelnemer/profiel.html.twig');
    }

    /**
     * @Route("/user/wachtwoord", name="ww_wijzigen")
     */
    public function wachtwoordAction(Request $request, UserPasswordEncoderInterface $encoder) {
        $user = $this->getUser();
        $form = $this->createForm(Ww_wijzigenType::class, $user);

        $form->add('save', SubmitType::class, ['label' => "aanpassen"]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $password = $encoder->encodePassword($user, $user->getPlainPassword());
            $user->setPassword($password);

            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();

            $this->addFlash('notice', 'wachtwoord gewijzigd!');
            return $this->redirectToRoute('profiel');
        }

        return $this->render('deelnemer/ww_wijzigen.html.twig', [
            'form' => $form->createView()
        ]);
    }
}
