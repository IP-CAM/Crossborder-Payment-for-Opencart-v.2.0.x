<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>">
        <?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-payment" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary">
          <i class="fa fa-save"></i>
        </button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><i class="fa fa-credit-card"></i>
        <?php echo $heading_title; ?>
      </h1>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-payment" class="form-horizontal">

        <?php if ($error_warning) { ?>
        <div class="alert alert-danger">
          <i class="fa fa-exclamation-circle"></i>
          <?php echo $error_warning; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } else if ($success) { ?>
        <div class="alert alert-success">
          <i class="fa fa-exclamation-circle"></i>
          <?php echo $success; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
          <div class="col-sm-10">
            <select name="globepay_status" class="form-control">

              <?php if ($globepay_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>

            </select>
          </div>
        </div>

        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-merchant"><?php echo $entry_account; ?></label>
          <div class="col-sm-10">
            <input type="text" name="globepay_account" value="<?php echo $globepay_account; ?>" class="form-control"/>
            <?php if ($error_account) { ?>
              <div class="text-danger"><?php echo $error_account; ?></div>
            <?php } ?>
          </div>
        </div>

        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-merchant"><?php echo $entry_secret; ?></label>
          <div class="col-sm-10">
            <input type="text" name="globepay_secret" value="<?php echo $globepay_secret; ?>" class="form-control"/>
            <?php if ($error_account) { ?>
              <div class="text-danger"><?php echo $error_secret; ?></div>
            <?php } ?>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_succeed_status; ?></label>
          <div class="col-sm-10">
            <select name="globepay_order_succeed_status_id" class="form-control">
              <?php foreach ($order_statuses as $order_status) {?>
                <?php if ($order_status['order_status_id'] == $globepay_order_succeed_status_id) {?>
                  <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_failed_status; ?></label>
          <div class="col-sm-10">
            <select name="globepay_order_failed_status_id" class="form-control">
              <?php foreach ($order_statuses as $order_status) {?>
                <?php if ($order_status['order_status_id'] == $globepay_order_failed_status_id) {?>
                  <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
          <div class="col-sm-10">
            <select name="globepay_geo_zone_id" class="form-control">
              <option value="0"><?php echo $text_all_zones ?></option>
              <?php foreach ($geo_zones as $geo_zone) {?>
                <?php if ($geo_zone['geo_zone_id'] == $globepay_geo_zone_id) {?>
                  <option value="<?php echo $geo_zone['geo_zone_id'] ?>" selected="selected"><?php echo $geo_zone['name'] ?></option>
                <?php } else { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id'] ?>"><?php echo $geo_zone['name'] ?></option>
                <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
          <div class="col-sm-10">
            <input type="text" name="globepay_sort_order" value="<?php echo $globepay_sort_order; ?>" class="form-control"/>
          </div>
        </div>

      </form>
    </div>
  </div>

</div>
