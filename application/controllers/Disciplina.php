<?php defined('BASEPATH') OR exit('No direct script access allowed');

  /**
   *  Essa classe é responsavel por todas regras de negócio sobre disciplinas.
   *  @since 2017/03/17
   *  @author Caio de Freitas
   */
  class Disciplina extends CI_Controller {

    public function index () {
      $this->cadastro();
    }


    // =========================================================================
    // ==========================CRUD de disciplinas============================
    // =========================================================================

    /**
      * Valida os dados do forumulário de cadastro de disciplinas.
      * Caso o formulario esteja valido, envia os dados para o modelo realizar
      * a persistencia dos dados.
      * @author Caio de Freitas
      * @since 2017/03/17
      */
    public function cadastro () {
      // Carrega a biblioteca para validação dos dados.
      $this->load->library(array('form_validation','session'));
      $this->load->helper(array('form','url'));
      $this->load->model(array('Disciplina_model'));

      // Definir as regras de validação para cada campo do formulário.
      $this->form_validation->set_rules('nome', 'nome do curso', array('required','min_length[5]','ucwords'));
      $this->form_validation->set_rules('sigla', 'sigla', array('required', 'max_length[5]', 'is_unique[Disciplina.sigla]','strtoupper'));
      // TODO adicionar a validação do curso
      $this->form_validation->set_rules('qtdProf', 'quantidade de professores', array('required', 'integer', 'greater_than[0]', 'less_than[10]'));
      // Definição dos delimitadores
      $this->form_validation->set_error_delimiters('<span class="text-danger">','</span>');

      // Verifica se o formulario é valido
      if ($this->form_validation->run() == FALSE) {

        $dados['disciplinas'] = $this->Disciplina_model->getDisciplinas();
	      $this->load->view('disciplinas', $dados);

      } else {

        // Pega os dados do formulário
        $disciplina = array(
          'nome'      => $this->input->post("nome"),
          'sigla'     => $this->input->post('sigla'),
          'qtdProf'   => $this->input->post("qtdProf")
        );

        if ($this->Disciplina_model->insertDisciplina($disciplina)){
          $this->session->set_flashdata('success','Disciplina cadastrada com sucesso');
        } else {
          $this->session->set_flashdata('danger','Não foi possivel cadastrar a disciplina, tente novamente ou entre em contato com o administrador do sistema');
        }

        redirect('/');

      }
    }

    /**
      * Deleta uma disciplina.
      * @author Caio de Freitas
      * @since  2017/03/21
      * @param $id ID da disciplina
      */
    public function deletar ($id) {
      // Carrega os modelos necessarios
      $this->load->model(array('Disciplina_model'));

      if ( $this->Disciplina_model->deleteDisciplina($id) )
        $this->session->set_flashdata('success','Disciplina deletada com sucesso');
      else
        $this->session->set_flashdata('danger','Não foi possivel deletar a disciplina, tente novamente ou entre em contato com o administrador do sistema');

      redirect('/');
    }

    /**
      * Altera os dado da disciplina.
      * @author Caio de Freitas
      * @since 2017/03/21
      * @param $id ID da disciplina
      */
    public function atualizar () {

      $this->load->library('form_validation');
      $this->load->model(array('Disciplina_model'));

      // Definir as regras de validação para cada campo do formulário.
      $this->form_validation->set_rules('recipient-nome', 'nome do curso', array('required','min_length[5]','ucwords'));
      $this->form_validation->set_rules('recipient-sigla', 'sigla', array('required', 'max_length[5]','strtoupper'));
      $this->form_validation->set_rules('recipient-qtd-prof', 'quantidade de professores', array('required', 'integer', 'greater_than[0]'));
      // Definição dos delimitadores
      $this->form_validation->set_error_delimiters('<span class="text-danger">','</span>');

      // Verifica se o formulario é valido
      if ($this->form_validation->run() == FALSE) {
        $dados['disciplinas'] = $this->Disciplina_model->getDisciplinas();
        $this->load->view('disciplinas', $dados);
      } else {

        $id = $this->input->post('recipient-id');

        // Pega os dados do formulário
        $disciplina = array(
          'nome'        => $this->input->post("recipient-nome"),
          'sigla'       => $this->input->post('recipient-sigla'),
          'qtdProf'     => $this->input->post("recipient-qtd-prof")
        );

        if ( $this->Disciplina_model->updateDisciplina($id, $disciplina) )
          $this->session->set_flashdata('success', 'Disciplina atualizada com sucesso');
        else
          $this->session->set_flashdata('danger','Não foi possivel atualizar os dados da disciplina, tente novamente ou entre em contato com o administrador do sistema');

        redirect('/');

      }
    }



  }

?>