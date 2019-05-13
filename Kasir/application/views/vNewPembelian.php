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
      <?php echo form_open_multipart('Pembelian/addTemp'); ?>
        <div class="form-group">
        <div class="row">
            <div class="col">
            <select class="form-control" id="id_barang" name="id_barang">
                <?php 
                foreach ($groups as $row) {
                  echo "<option value='".$row->id_barang."'harga_barang='".$row->harga_barang."'>".$row->nama_barang."</option>";
                }
                ?>
              </select>
              
            </div>
            <div class="col">
                <input type="number" name="harga_barang" class="form-control" placeholder="Harga Barang" readonly>
            </div>
            </div>
        </div>
        <div class="form-group">
        <div class="row">

            <div class="col">
                <input type="text" name="total_barang" class="form-control" placeholder="Jumlah Barang">
            </div>
            <div class="col">
                <input type="text" name="keterangan_barang" class="form-control" placeholder="Keterangan Barang">
            </div>
            </div>
        </div>
        <button type="submit" class="btn btn-primary mb-2">Confirm Data</button>
        <?php echo form_close(); ?>

    <?php echo form_open_multipart('Pembelian/addPembelian'); ?>         
      <table id="table" class="table table-striped table-bordered table-active" cellspacing="0" width="100%">
        <thead class="thead-dark">
          <tr>
            <th>No</th>
            <th>Nama</th>
            <th>Jumlah</th>
            <th>Harga</th>
            <th>Sub Total</th>
            <th>Keterangan</th>
            <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <!--Fetch data dari database-->
          <?php $i=1;
          $numstart = $this->uri->segment(3) + 1;
          ?>
          <?php 
          $total=0;
          foreach($tampil as $tmpl) {
            $total = $total + $tmpl->sub_total;
              ;?>
            <tr>
             <td><?php echo $numstart; ?></td>
             <td><?php echo $tmpl->nama_barang; ?></td>
             <td><?php echo $tmpl->total_barang; ?></td>
             <td><?php echo $tmpl->harga_barang; ?></td>
             <td><?php echo $tmpl->sub_total; ?></td>
             <td><?php echo $tmpl->keterangan; ?></td>
             <td><a class="btn btn-info a-btn-slide-trash" data-toggle="modal" data-target="#delete<?php echo $tmpl->id_barang; ?>"><i class="fas fa-fw fa-trash"></i>        
            </a></td>
          </tr>
          <?php
            $i++;
            $numstart++;
           } ?>
        </tbody>
        <tfoot>
        <tr>
            <th scope="row">Total</th>
            <td><?php echo $total; ?></td>
            <input type="hidden" name="total" value="<?php echo $total; ?>">
        </tr>
        </tfoot>
      </table>
      <button type="submit" class="btn btn-primary mb-2" >Proses Pembelian</button>
      <?php echo form_close(); ?>
</div>
<?php $this->load->view("_partials/footer.php") ?>

</div>
<!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->

<?php $this->load->view("_partials/scrolltop.php") ?>
<?php $this->load->view("_partials/modal.php") ?>
<?php $this->load->view("_partials/js.php") ?>

</body>
</html>