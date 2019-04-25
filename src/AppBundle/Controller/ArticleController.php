<?php

namespace AppBundle\Controller;

use AppBundle\Entity\Article;
use AppBundle\Entity\Author;
use AppBundle\Repository\ArticleRepository;
use AppBundle\Repository\AuthorRepository;
use FOS\RestBundle\Controller\Annotations as Rest;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\View\View;
use JMS\DiExtraBundle\Annotation as DI;

/**
 * Class ArticleController
 * @package AppBundle\Controller
 */
class ArticleController extends Controller
{

    /**
     * @var ArticleRepository
     */
    private $articleRep;

    /**
     * @var AuthorRepository
     */
    private $authorRep;

    /**
     * ArticleController constructor.
     * @param ArticleRepository $articleRep
     * @param AuthorRepository $authorRep
     */
    public function __construct(ArticleRepository $articleRep, AuthorRepository $authorRep)
    {
        $this->articleRep = $articleRep;
        $this->authorRep = $authorRep;
    }


    /**
     * @Rest\Get("/rest/articles")
     * @Rest\View
     */
    public function listAction()
    {
       // $this->denyAccessUnlessGranted('ROLE_ADMIN', null, 'Unable to access this page!');

        //$em = $this->getDoctrine()->getManager();
        $articles = $this->articleRep->findAll();

        if (!$articles) {
             return new View("there are no articles exist", Response::HTTP_NOT_FOUND);
          }

        return $articles;
    }

    /**
     * @Rest\Get("/rest/article/{id}")
     * @Rest\View
     */
    public function showAction($id)
    {
//        $em = $this->getDoctrine()->getManager();
//        $article = $em->getRepository(Article::class)->find($id);

        // Use dependency injection
        $article = $this->articleRep->findOneById($id);

        if (!$article) {
             return new View("Article not found", Response::HTTP_NOT_FOUND);
          }

        return $article;
    }

    /**
     * @Rest\Get("/rest/articles/{idAuthor}")
     * @Rest\View
     */
    public function listByAuthorAction($idAuthor)
    {

        // Use dependency injection
        $articles = $this->articleRep->getArticlesByAuthor($idAuthor);

        if (!$articles) {
            return new View("no article found", Response::HTTP_NOT_FOUND);
        }

        return $articles;
    }


    /**
     * @Rest\Post("/rest/article")
     * @Rest\View
     */
    public function createAction(Request $request)
    {

        try {

            $idAuthor = $request->request->get('auteur');
            $title = $request->request->get('title');
            $content = $request->request->get('content');

            // requered values
            if(empty($title) || empty($idAuthor))
            { return new View("NULL VALUES ARE NOT ALLOWED FOR TITLE AND AUTHOR", Response::HTTP_NOT_ACCEPTABLE); }

            $author = $this->authorRep->find($idAuthor);

            if(!$author)
            { return new View("Author not found", Response::HTTP_NOT_FOUND); }

            $article =  new Article();
            $article->setTitle($title);
            $article->setContent($content);
            $article->setAuthor($author);

            $this->articleRep->saveArticle($article);

        }
        catch (\Exception $e) {
               return  $e->getMessage()."\n".$e->getTraceAsString();
        }

        return $article;
    }

    /**
     * @Rest\Put("/rest/article/{id}")
     * @Rest\View
     */
    public function updateAction($id, Request $request)
    {

        try {

            $data = json_decode($request->getContent(), true);

            $article = $this->articleRep->findOneById($id);

            if (!$article)
            { return new View("Article not found", Response::HTTP_NOT_FOUND); }

            if(!empty($data['title']))
            { $article->setTitle($data['title']); }

            if(isset($data['content']))
            { $article->setContent($data['content']); }

            if(!empty($data['auteur'])) {
                $author = $this->authorRep->find($data['auteur']);

                if(!$author)
                { return new View("Author not found", Response::HTTP_NOT_FOUND); }

                $article->setAuthor($author);
            }

            $this->articleRep->updateArticle($article);
        }
        catch (\Exception $e) {
            return  $e->getMessage()."\n".$e->getTraceAsString();
        }

        return $article;
    }

    /**
     * @Rest\Delete("/rest/article/{id}")
     * @Rest\View
     */
    public function removeAction($id)
    {
        $article = $this->articleRep->findOneById($id);

        if (!$article) {
            return new View("Article not found", Response::HTTP_NOT_FOUND);
        }

        $this->articleRep->removeArticle($article);

        return new View("Article deleted successfully", Response::HTTP_OK);
    }
}