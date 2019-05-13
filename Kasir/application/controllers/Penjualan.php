<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH.'controllers/Barang.php');

class Penjualan extends CI_Controller {
    function __construct(){
        parent::__construct();
        $this->load->library('session');
$this->load->database(); // load database
$this->load->library('table');
$this->load->helper('date');
$this->load->helper('url');
$this->load->library('pagination');
$this->load->model('mPenjualan');
$this->load->helper('form');
        if($this->session->has_userdata('email')) {
        } else {
            redirect('login');
        }
}
public function index()
{

	 	$config['base_url'] = site_url('Penjualan/index'); //site url
        $config['total_rows'] = $this->db->count_all('tbl_penjualan'); //total row
        $config['per_page'] = 5;  //show record per halaman
        $config["uri_segment"] = 4;  // uri parameter
        $choice = $config["total_rows"] / $config["per_page"];
        $config["num_links"] = floor($choice);

        //load view mahasiswa view


        // Membuat Style pagination untuk BootStrap v4
        $config['first_link']       = 'First';
        $config['last_link']        = 'Last';
        $config['next_link']        = 'Next';
        $config['prev_link']        = 'Prev';
        $config['full_tag_open']    = '<div class="pagging text-center"><nav><ul class="pagination justify-content-center">';
        $config['full_tag_close']   = '</ul></nav></div>';
        $config['num_tag_open']     = '<li class="page-item"><span class="page-link">';
        $config['num_tag_close']    = '</span></li>';
        $config['cur_tag_open']     = '<li class="page-item active"><span class="page-link">';
        $config['cur_tag_close']    = '<span class="sr-only">(current)</span></span></li>';
        $config['next_tag_open']    = '<li class="page-item"><span class="page-link">';
        $config['next_tagl_close']  = '<span aria-hidden="true">&raquo;</span></span></li>';
        $config['prev_tag_open']    = '<li class="page-item"><span class="page-link">';
        $config['prev_tagl_close']  = '</span>Next</li>';
        $config['first_tag_open']   = '<li class="page-item"><span class="page-link">';
        $config['first_tagl_close'] = '</span></li>';
        $config['last_tag_open']    = '<li class="page-item"><span class="page-link">';
        $config['last_tagl_close']  = '</span></li>';

        $this->pagination->initialize($config);
        $data['page'] = ($this->uri->segment(3) ? $this->uri->segment(3) : 0);

        //panggil function get_mahasiswa_list yang ada pada mmodel mahasiswa_model. 
        $data['data'] = $this->mPenjualan->get_penjualan_list($config["per_page"], $data['page']);           

        $data['pagination'] = $this->pagination->create_links();

      	$data['title'] = "Table Of Item"; //title web
          $data['tampil'] = $this->mPenjualan->tampil($config["per_page"], $data['page']);
          $data['tampildetail'] = $this->mPenjualan->tampildetail($config["per_page"], $data['page']);
          $data['groups'] = $this->mPenjualan->get_name_item();
          $this->load->view('vPenjualan',$data);
      }
    public function newPenjualan(){
        $data['tampil'] = $this->mPenjualan->tempdata();
        $data['groups'] = $this->mPenjualan->get_name_item();
        $this->load->view('vNewPenjualan',$data);
    }
    public function addTemp(){
        $data['id_barang'] = $this->input->post('id_barang');
        $data['total_barang'] = $this->input->post('total_barang');
        $data['harga_barang'] = $this->input->post('harga_barang');
        $data['sub_total'] = $data['harga_barang'] * $data['total_barang'];

        $this->mPenjualan->save_itemTemp($data, 'tbl_temppenjualan');
        redirect('Penjualan/newPenjualan');
    }
    public function addPenjualan(){
        
        $data['tanggal'] = date('y-m-d');
        $data['total_penjualan'] = $this->input->post('total');
        $temp = $this->mPenjualan->tempdata();
        $lastid = $this->mPenjualan->save_penjualan($data,'tbl_penjualan');
       
        foreach($temp as $tmp){
            $data_insert[] = array(
            'id_penjualan' => $lastid,
            'id_barang' => $tmp->id_barang,
            'jumlah_barang' => $tmp->total_barang,
            'harga_barang' => $tmp->harga_barang,
            'sub_total' => $tmp->sub_total,
            );
        }     
        $this->mPenjualan->save_detail($data_insert,'tbl_detailpenjualan');
        redirect('Penjualan');
    }
    public function deleteAll(){
        $this->mPenjualan->delete_allitem('tbl_temppenjualan');
        redirect('Penjualan/newPenjualan');
    }
}

