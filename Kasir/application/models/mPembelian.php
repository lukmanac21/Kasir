<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class mPembelian extends CI_Model {
	function tempdata($limit = 999, $start = 0){
		$this->db->select('*');
		$this->db->from('tbl_temp');
		$this->db->join('tbl_barang','tbl_temp.id_barang =tbl_barang.id_barang','inner');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}

	function tampil($limit = 999, $start = 0)
	{
		$this->db->select('*');
		$this->db->from('tbl_pembelian');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}
	function get_pembelian_list($limit, $start){
		$query = $this->db->get('tbl_pembelian', $limit, $start);
		return $query;
    }
    function get_name_item(){
        $query = $this->db->query('SELECT * FROM tbl_barang');
		return $query->result();
	}
	function save_itemTemp($data,$tbl){
		$this->db->insert($tbl,$data);
	}
    function save_pembelian($data,$tbl){
		$this->db->insert($tbl,$data);
		$insert_id = $this->db->insert_id();
		return $insert_id;
	}
	function save_detail($data_detail,$tbl){
		$this->db->insert_batch($tbl, $data_detail); 
	}
	
}
?>