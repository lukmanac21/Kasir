<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class mPenjualan extends CI_Model {

	function tampil($limit = 999, $start = 0)
	{
		$this->db->select('*');
		$this->db->from('tbl_penjualan');
		$this->db->limit($limit, $start);
		$query = $this->db->get();
		return $query->result();
	}
	function get_user_list($limit, $start){
		$query = $this->db->get('tbl_penjualan', $limit, $start);
		return $query;
	}

}
?>