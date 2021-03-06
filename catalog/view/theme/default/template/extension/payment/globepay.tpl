<div class="alert alert-warning text-danger" id="warning" style="display:none;"></div>

<div class="buttons">
  <div class="pull-right">
    &nbsp;&nbsp;<input type="button" id="btn-globepay-confirm" class="btn btn-primary" value="<?php echo $button_confirm ?>">
  </div>
</div>

<script type="text/javascript">
  (function($) {

    $('#btn-globepay-confirm').click(function() {
      $('#warning').hide();
      $.ajax({
        type: 'POST',
        url: '<?php echo $payment_submit_url ?>',
        data: {
          comment: $('textarea[name=comment]').val()
        },
        dataType: 'json',
        beforeSend: function() {
          $('#btn-globepay-confirm').attr('disabled', 'disabled').val('<?php echo $button_loading ?>');
        },
        success: function(json) {
          if (json['info']) {
            $('#btn-globepay-confirm').removeAttr('disabled').val('<?php echo $button_confirm ?>');
            $('#warning').show().text(json['info']);
            return;
          }

          if (json['error']) {
            $('#btn-globepay-confirm').removeAttr('disabled').val('<?php echo $button_confirm ?>');
            $('#warning').show().text(json['error']);
            return;
          }

          if (json['success']) {
            location = json['success'];
          }
        },
        error: function(e) {
          $('#btn-globepay-confirm').removeAttr('disabled').val('<?php echo $button_confirm ?>');
          console.warn(e.responseText);
          $('#warning').show().text('Server internal error, please try again later.');
        }
      });
    });

    $(function() {
      var $btn_submiter = $('#journal-checkout-confirm-button');
      if ($btn_submiter.length > 0) {
        $btn_submiter.click(function() {
          if ($('input[name=agree]:checked').length > 0) {
            if ($('input[name=payment_method]:checked').val() == 'globepay') {
              $('#warning').hide();
              $.ajax({
                type: 'POST',
                url: '<?php echo $payment_submit_url ?>',
                data: {
                  comment: $('textarea[name=comment]').val()
                },
                dataType: 'json',
                beforeSend: function() {
                  $btn_submiter.attr('disabled', 'disabled').text('<?php echo $button_loading ?>');
                },
                success: function(json) {
                  if (json['info']) {
                    $('#btn-globepay-confirm').removeAttr('disabled').val('<?php echo $button_confirm ?>');
                    $('#warning').show().text(json['info']);
                    return;
                  }

                  if (json['error']) {
                    $('#btn-globepay-confirm').removeAttr('disabled').val('<?php echo $button_confirm ?>');
                    $('#warning').show().text(json['error']);
                    return;
                  }

                  if (json['success']) {
                    location = json['success'];
                  }
                },
                error: function(e) {
                  $btn_submiter.removeAttr('disabled').text('<?php echo $button_confirm ?>');
                  console.warn(e.responseText);
                  $('#warning').show().text('Server internal error, please try again later.');
                }
              });
              return false;
            }

          }
        });
      }
    });
  })(jQuery);
</script>
