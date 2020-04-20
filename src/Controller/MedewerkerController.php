<?php

namespace App\Controller;

use App\Entity\Activiteit;
use App\Entity\Soortactiviteit;
use App\Entity\User;
use App\Form\ActiviteitType;
use App\Form\SoortactiviteitType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class MedewerkerController extends AbstractController {
    /**
     * @Route("/admin/activiteiten", name="activiteitenoverzicht")
     */
    public function activiteitenOverzichtAction() {
        $activiteiten=$this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->findAll();

        $repository = $this->getDoctrine()->getRepository(Soortactiviteit::class);
        $soortactiviteiten = $repository->findAll();

        return $this->render('medewerker/activiteiten.html.twig', [
            'activiteiten'=>$activiteiten,
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/details/{id}", name="details")
     */
    public function detailsAction($id) {
        $activiteiten=$this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->findAll();
        $activiteit=$this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->find($id);

        $deelnemers=$this->getDoctrine()
            ->getRepository('App:User')
            ->getDeelnemers($id);

        $repository = $this->getDoctrine()->getRepository(Soortactiviteit::class);
        $soortactiviteiten = $repository->findAll();

        return $this->render('medewerker/details.html.twig', [
            'activiteit'=>$activiteit,
            'deelnemers'=>$deelnemers,
            'aantal'=>count($activiteiten),
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/beheer", name="beheer")
     */
    public function beheerAction() {
        $activiteiten = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->findAll();

        $repository = $this->getDoctrine()->getRepository(Soortactiviteit::class);
        $soortactiviteiten = $repository->findAll();

        return $this->render('medewerker/beheer.html.twig', [
            'activiteiten'=>$activiteiten,
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/activiteit_toevoegen/{type}", name="activiteit_toevoegen")
     */
    public function addAction(Request $request, $type) {
        if($type == 'activiteit') {
            $a = new Activiteit();
            $formType = ActiviteitType::class;
            $redirect = 'beheer';
        } elseif ($type == 'soortactiviteit') {
            $a = new Soortactiviteit();
            $formType = SoortactiviteitType::class;
            $redirect = 'soortactiviteiten';
        }

        $form = $this->createForm($formType, $a);
        $form->add('save', SubmitType::class, array('label'=>"voeg toe"));
        //$form->add('reset', ResetType::class, array('label'=>"reset"));

        $repository = $this->getDoctrine()->getRepository(Soortactiviteit::class);
        $soortactiviteiten = $repository->findAll();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $em = $this->getDoctrine()->getManager();
            $em->persist($a);
            $em->flush();

            $this->addFlash(
                'notice',
                'activiteit toegevoegd!'
            );
            return $this->redirectToRoute($redirect);
        }

        $activiteiten = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->findAll();
        return $this->render('medewerker/activiteit_toevoegen.html.twig', [
            'form'=>$form->createView(),
            'aantal'=>count($activiteiten),
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/update/{id}", name="update")
     */
    public function updateAction($id,Request $request) {
        $a = $this->getDoctrine()
            ->getRepository('App:Activiteit')
            ->find($id);

        $form = $this->createForm(ActiviteitType::class, $a);
        $form->add('save', SubmitType::class, ['label' => "aanpassen"]);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();

            $em->persist($a);
            $em->flush();

            $this->addFlash('notice','activiteit aangepast!');

            return $this->redirectToRoute('beheer');
        }

        $activiteiten = $this->getDoctrine()
            ->getRepository(Activiteit::class)
            ->findAll();

        $soortactiviteiten = $this->getDoctrine()
            ->getRepository(Soortactiviteit::class)
            ->findAll();

        return $this->render('medewerker/activiteit_toevoegen.html.twig', [
            'form' => $form->createView(),
            'naam' => 'aanpassen',
            'aantal' => count($activiteiten),
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/delete/{type}/{id}", name="delete")
     */
    public function deleteAction($type, $id) {
        if($type == 'activiteit') {
            $delete = Activiteit::class;
            $returnpage = 'beheer';
        } elseif ($type == 'soortactiviteit') {
            $delete = Soortactiviteit::class;
            $returnpage = 'soortactiviteiten';
        } elseif ($type == 'deelnemer') {
            $delete = User::class;
            $returnpage = 'deelnemers';
        }

        $a = $this->getDoctrine()
            ->getRepository($delete)->find($id);

        $em = $this->getDoctrine()->getManager();
        $em->remove($a);
        $em->flush();

        $this->addFlash(
            'notice',
            'verwijderd!'
        );

        return $this->redirectToRoute($returnpage);
    }

    /**
     * @Route("/admin/soortactiviteiten", name="soortactiviteiten")
     */
    public function activiteitSoortenAction() {
        $activiteiten = $this->getDoctrine()->getRepository('App:Activiteit')->findAll();

        $soortactiviteiten = $this->getDoctrine()->getRepository(Soortactiviteit::class)->findAll();

        return $this->render('medewerker/soortactiviteiten.html.twig',[
            'activiteiten'=>$activiteiten,
            'soortactiviteiten' => $soortactiviteiten
        ]);
    }

    /**
     * @Route("/admin/deelnemers", name="deelnemers")
     */
    public function deelnemersAction() {
        $activiteiten = $this->getDoctrine()->getRepository('App:Activiteit')->findAll();

        $soortactiviteiten = $this->getDoctrine()->getRepository(Soortactiviteit::class)->findAll();

        $deelnemers = $this->getDoctrine()->getRepository(User::class)->findAll();

        return $this->render('medewerker/deelnemers.html.twig',[
            'activiteiten'=>$activiteiten,
            'soortactiviteiten' => $soortactiviteiten,
            'deelnemers' => $deelnemers
        ]);
    }
}
