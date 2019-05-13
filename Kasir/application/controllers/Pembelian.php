<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH.'controllers/Barang.php');

class Pembelian extends CI_Controller {
    function __construct(){
        parent::__construct();
        $this->load->library('session');
$this->load->database(); // load database
$this->load->library('table');
$this->load->helper('date');
$this->load->helper('url');
$this->load->library('pagination');
$this->load->model('mPembelian');
$this->load->helper('form');
        if($this->session->has_userdata('email')) {
        } else {
            redirect('login');
        }
}
public function index()
{

	 	$config['base_url'] = site_url('Pembelian/index'); //site url
        $config['total_rows'] = $this->db->count_all('tbl_pembelian'); //total row
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
        $data['data'] = $this->mPembelian->get_pembelian_list($config["per_page"], $data['page']);           

        $data['pagination'] = $this->pagination->create_links();

      	$data['title'] = "Table Of Item"; //title web
          $data['tampil'] = $this->mPembelian->tampil($config["per_page"], $data['page']);
          $data['groups'] = $this->mPembelian->get_name_item();
          $this->load->view('vPembelian',$data);
      }
    public function newPembelian(){
        $data['tampil'] = $this->mPembelian->tempdata();
        $data['groups'] = $this->mPembelian->get_name_item();
        $this->load->view('vNewPembelian',$data);
    }
    public function addTemp(){
        $data['id_barang'] = $this->input->post('id_barang');
        $data['total_barang'] = $this->input->post('total_barang');
        $data['harga_barang'] = $this->input->post('harga_barang');
        $data['keterangan'] = $this->input->post('keterangan_barang');
        $data['sub_total'] = $data['harga_barang'] * $data['total_barang'];

        $this->mPembelian->save_itemTemp($data, 'tbl_temp');
        redirect('Pembelian/newPembelian');
    }
    public function addPembelian(){
        $data['tanggal'] = date('y-m-d');
        $data['total_pembelian'] = $this->input->post('total');
        $data_detail = array();
        $temp = $this->mPembelian->tempdata();
        foreach($temp as $tmp){
            $data_insert[] = array(
            'nama_barang' => $tmp->nama_barang,
            'jumlah_barang' => $tmp->jumlah_barang,
            'harga_barang' => $tmp->harga_barang,
            'keterangan' => $tmp->keterangan,
            );
            $data_detail[] = $data_insert;
        }       
        $this->mPembelian->save_pembelian($data,'tbl_pembelian');
        $this->mPembelian->save_detail($data_detail,'tbl_detailpembelian');
        redirect('Pembelian');

    }
}

