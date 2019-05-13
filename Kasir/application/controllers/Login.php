<?php
/**
 * Created by PhpStorm.
 * User: LUKMAN
 * Date: 12/01/2019
 * Time: 10:23
 */
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH.'controllers/Login.php');
class Login extends CI_Controller
{
    function __construct()
        {
            parent::__construct();
            $this->load->library('session');
            $this->load->database(); // load database
            $this->load->helper('url');
            $this->load->model('mLogin');
            $this->load->helper('form');
        }
    public function index(){
        $this->load->view('vLogin');
    }
    public function login_proses(){
        $email = $this->input->post('email');
        $pass = $this->input->post('password');
        $where = array(
            'email_user' => $email,
            'password_user' => $pass
        );
        $query = $this->mLogin->validation("tbl_user", $where)->num_rows();
        if ($query > 0){
            $data_session = array(
                'email' => $email,
                'status' => "Logged In"
            );
            $this->session->set_userdata($data_session);
            redirect('Barang');
        }
        else{
            echo '<script> alert ("Error Email or Password")</script>';
            $this->load->view('vLogin');
        }

    }
    public function logout()
    {
        $this->session->sess_destroy();
        redirect('Login');
    }

}