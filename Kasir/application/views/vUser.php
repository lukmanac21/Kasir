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
      <br>
      <br>

      <table id="table" class="table table-striped table-bordered table-active" cellspacing="0" width="100%">
        <thead class="thead-dark">
          <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Email</th>
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
             <td><?php echo $tmpl->name_user; ?></td>
             <td><?php echo $tmpl->email_user; ?></td>
          </tr>
          <?php $i++;
          $numstart++; } ?>
        </tbody>
      </table>
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