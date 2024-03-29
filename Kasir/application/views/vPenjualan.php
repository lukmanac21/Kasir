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
      <h1>Data <strong>Penjualan</strong></h1>
      <br>
      <br>

      <table id="table" class="table table-striped table-bordered table-active" cellspacing="0" width="100%">
        <thead class="thead-dark">
          <tr>
            <th>No</th>
            <th>Tanggal</th>
            <th>Total Penjualan</th>
            <th>Detail</th>
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
             <td><?php echo $tmpl->tanggal; ?></td>
             <td><?php echo $tmpl->total_penjualan; ?></td>
             <td><a class="btn btn-info a-btn-slide-text" data-toggle="modal" data-target="#detail<?php echo $tmpl->id_penjualan; ?>"><i class="fas fa-fw fa-edit"></i>        
            </a></td>
          </tr>
          <?php $i++;
          $numstart++; } ?>
        </tbody>
      </table>
      <?php foreach($tampil as $tmpl) {;?>
 <div class="modal fade" id="detail<?php echo $tmpl->id_penjualan;?>">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
     <div class="modal-header">
      <h4 class="modal-title">Detail Penjualan</h4>
      <button type="button" class="close" data-dismiss="modal">&times;</button>
    </div>
    <div class="modal-body">
    <table id="table" class="table table-striped table-bordered table-active" cellspacing="0" width="100%">
        <thead class="thead-dark">
          <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Jumlah</th>
            <th>Harga</th>
            <th>Sub Total</th>
          </tr>
        </thead>
        <tbody>
          <!--Fetch data dari database-->
          <?php $i=1;
          $numstart = $this->uri->segment(3) + 1;
          ?>
          <?php foreach($tampildetail as $tmpls) {;?>
            <tr>
             <td><?php echo $numstart; ?></td>
             <td><?php echo $tmpls->nama_barang; ?></td>
             <td><?php echo $tmpls->jumlah_barang; ?></td>
             <td><?php echo $tmpls->harga_barang; ?></td>
             <td><?php echo $tmpls->sub_total; ?></td>
          </tr>
          <?php $i++;
          $numstart++; } ?>
        </tbody>
      </table>
  </div>
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