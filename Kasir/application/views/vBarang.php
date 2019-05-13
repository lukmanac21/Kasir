<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<!DOCTYPE html>
<html lang="id">
<head>
	<?php $this->load->view("_partials/head.php") ?>
  <meta charset="utf-8">
  <title>Data Barang</title>
  <!--Load file bootstrap.css-->
  <link rel="stylesheet" type="text/css" href="<?php echo base_url().'assets/css/bootstrap.css'?>">
  <link href="<?php echo base_url().'assets/datatables/css/dataTables.bootstrap.css'?>" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body id = "page-top">
	<?php $this->load->view("_partials/navbar.php") ?>
  <div id="wrapper">

   <?php $this->load->view("_partials/sidebar.php") ?>

   <div id="content-wrapper">

    <div class="container-fluid">
      <h1>Data <strong>Item</strong></h1>
      <button class="btn btn-success" data-toggle="modal" data-target="#addItem" onclick=""><i class="fas fa-fw fa-plus"></i> Tambah Data</button>
      <br>
      <br>

      <table id="table" class="table table-striped table-bordered table-active" cellspacing="0" width="100%">
        <thead class="thead-dark">
          <tr>
            <th>No</th>
            <th>Nama Barang</th>
            <th>Stok Barang</th>
            <th>Harga Barang</th>
            <th>Edit</th>
          </tr>
        </thead>
        <tbody>
          <!--Fetch data dari database-->
          <?php $i=1;
          $numstart = $this->uri->segment(3) + 1;
          ?>
          <?php foreach($tampil as $tmpl) {;?>
            <tr>
             <td><?php echo $numstart; ?></td>
             <td><?php echo $tmpl->nama_barang; ?></td>
             <td><?php echo $tmpl->stok_barang; ?></td>
             <td><?php echo $tmpl->harga_barang; ?></td>
             <td><a class="btn btn-info a-btn-slide-text" data-toggle="modal" data-target="#edit<?php echo $tmpl->id_barang; ?>"><i class="fas fa-fw fa-edit"></i>        
            </a></td>
            
          </tr>
          <?php $i++;
          $numstart++; } ?>
        </tbody>
      </table>
      <div class="modal fade" id="addItem">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
           <div class="modal-header">
            <h4 class="modal-title">Barang Baru</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>
          <div class="modal-body">
            <?php echo form_open_multipart('Barang/addItem'); ?>
            <div class="form-group">
              <input type="text" name="nama_barang" class="form-control" id="nama_barang" placeholder="Nama Barang">
            </div>
            <div class="form-group">
              <input type="number" name="jumlah_barang" class="form-control" id="jumlah_barang" placeholder="Jumlah Barang">
            </div>           
            <div class="form-group">
              <input type="number" name="harga_barang" class="form-control" id="harga_barang" placeholder="Harga Barang">
            </div>
        </div>
        <div class="modal-footer">
          <div class="form-group pull-right">
           <button type="submit" id="additem" class="btn btn-primary">Tambah Barang Baru</button>
         </div>
       </div>
       <?php echo form_close(); ?>
     </div>
   </div>
 </div>
 <?php foreach($tampil as $tmpl) {;?>
 <div class="modal fade" id="edit<?php echo $tmpl->id_barang;?>">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
     <div class="modal-header">
      <h4 class="modal-title">Ubah Barang</h4>
      <button type="button" class="close" data-dismiss="modal">&times;</button>
    </div>
    <div class="modal-body">
      <?php echo form_open_multipart('Barang/editItem'); ?>
      <div class="form-group">
        <input type="hidden" name="id_barang" value="<?php echo $tmpl->id_barang; ?>">
        <input type="text" name="nama_barang" class="form-control" id="nama_barang" value="<?php echo $tmpl->nama_barang; ?>">
      </div>
      <div class="form-group">
        <input type="number" name="jumlah_barang" class="form-control" id="jumlah_barang" value="<?php echo $tmpl->stok_barang; ?>" readonly>
      </div>           
      <div class="form-group">
        <input type="number" name="harga_barang" class="form-control" id="harga_barang"  value="<?php echo $tmpl->harga_barang; ?>">
      </div>
  </div>
  <div class="modal-footer">
    <div class="form-group pull-right">
     <button type="submit" id="addmovie" class="btn btn-primary">Simpan</button>
   </div>
 </div>
 <?php echo form_close(); ?>
</div>
</div>
</div>
<?php } ?>
</div>
<?php $this->load->view("_partials/footer.php") ?>
<div class="row">
  <div class="col">
    <!--Tampilkan pagination-->
    <?php echo $pagination; ?>
  </div>
</div>

</div>
<!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->


<?php $this->load->view("_partials/scrolltop.php") ?>
<?php $this->load->view("_partials/modal.php") ?>
<?php $this->load->view("_partials/js.php") ?>

</body>
</html>