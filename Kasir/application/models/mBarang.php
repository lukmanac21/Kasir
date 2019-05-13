<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class mBarang extends CI_Model {

	function tampil($limit = 999, $start = 0)
	{
		$this->db->select('*');
		$this->db->from('tbl_barang');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}
	function get_item_list($limit, $start){
		$query = $this->db->get('tbl_barang', $limit, $start);
		return $query;
	}
	function save_item($data, $tbl){
		$this->db->insert($tbl,$data);
	}
	function edit_item($where, $data, $tbl){
		$this->db->where($where);
		$this->db->update($tbl, $data);
	}
	function delete_item($where, $tbl){
		$this->db->where($where);
		$this->db->delete($tbl);
	}

}
?>