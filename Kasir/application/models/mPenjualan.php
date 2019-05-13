<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class mPenjualan extends CI_Model {
	function tempdata($limit = 999, $start = 0){
		$this->db->select('*');
		$this->db->from('tbl_temppenjualan');
		$this->db->join('tbl_barang','tbl_temppenjualan.id_barang =tbl_barang.id_barang','inner');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}

	function tampil($limit = 999, $start = 0)
	{
		$this->db->select('*');
		$this->db->from('tbl_penjualan');
		$this->db->join('tbl_detailpenjualan','tbl_penjualan.id_penjualan =tbl_detailpenjualan.id_penjualan','inner');
		$this->db->join('tbl_barang','tbl_detailpenjualan.id_barang =tbl_barang.id_barang','inner');
		$this->db->group_by('tbl_penjualan.id_penjualan');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}
	function tampildetail($limit = 999, $start = 0)
	{
		$this->db->select('*');
		$this->db->from('tbl_penjualan');
		$this->db->join('tbl_detailpenjualan','tbl_penjualan.id_penjualan =tbl_detailpenjualan.id_penjualan','inner');
		$this->db->join('tbl_barang','tbl_detailpenjualan.id_barang =tbl_barang.id_barang','inner');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}

	function get_penjualan_list($limit, $start){
		$query = $this->db->get('tbl_penjualan', $limit, $start);
		return $query;
    }
    function get_name_item(){
        $query = $this->db->query('SELECT * FROM tbl_barang');
		return $query->result();
	}
	function save_itemTemp($data,$tbl){
		$this->db->insert($tbl,$data);
	}
    function save_penjualan($data,$tbl){
		$this->db->insert($tbl,$data);
		$last = $this->db->insert_id();
		return $last;	
	}
	function save_detail($data_detail,$tbl){
		$this->db->insert_batch($tbl, $data_detail); 
	}
	function delete_allitem($tbl){
		$this->db->empty_table($tbl);
	}
	
}
?>