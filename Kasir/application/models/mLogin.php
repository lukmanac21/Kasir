<?php
/**
 * Created by PhpStorm.
 * User: LUKMAN
 * Date: 12/01/2019
 * Time: 10:51
 */
defined('BASEPATH') OR exit('No direct script access allowed');
class mLogin extends CI_Model
{
    function validation($table,$where){
        return $this->db->get_where($table,$where);
    }
}