<?php

class Controllerextensionpaymentglobepayalipay extends Controller
{

    private $error = array();
    private function _redirect($url, $status = 302) {
        header('Location: ' . str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $url), true, $status);
        exit();
    }

    public function is_version_2000(){
        return version_compare(VERSION, '2.0.0.0','>=');
    }

    public function index()
    {
      ini_set('display_errors', 1);
      ini_set('display_startup_errors', 1);
      error_reporting(E_ALL);
        $this->load->model('setting/setting');
        $this->load->language('extension/payment/globepayalipay');
        $this->document->setTitle($this->language->get('heading_title'));
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('globepayalipay', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');

            $url =$this->url->link('extension/extension', 'type=payment&token=' . $this->session->data['token'], 'SSL');

             $this->_redirect($url);
        }

        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_all_zones'] = $this->language->get('text_all_zones');
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');

        $data['entry_account'] = $this->language->get('entry_account');
        $data['entry_secret'] = $this->language->get('entry_secret');

        $data['entry_rate'] = $this->language->get('entry_rate');
        $data['entry_order_status'] = $this->language->get('entry_order_status');
        $data['entry_order_succeed_status'] = $this->language->get('entry_order_succeed_status');
        $data['entry_order_payWait_status_id'] = $this->language->get('entry_order_payWait_status_id');
        $data['entry_order_failed_status'] = $this->language->get('entry_order_failed_status');

        $data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['tab_general'] = $this->language->get('tab_general');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
          $data['success'] = $this->session->data['success'];

          unset($this->session->data['success']);
        } else {
          $data['success'] = '';
        }

        if (isset($this->error['account'])) {
            $data['error_account'] = $this->error['account'];
        } else {
            $data['error_account'] = '';
        }

        if (isset($this->error['secret'])) {
            $data['error_secret'] = $this->error['secret'];
        } else {
            $data['error_secret'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' =>false
        );


        $url_payment =$this->url->link('extension/extension', 'type=payment&token=' . $this->session->data['token'], 'SSL');

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_payment'),
            'href' => $url_payment,
            'separator' => '::'
        );
        $url_payment= $this->url->link('extension/payment/globepayalipay', 'token=' . $this->session->data['token'], 'SSL');

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' =>$url_payment,
            'separator' => '::'
        );

        $data['action'] = $this->url->link('extension/payment/globepayalipay', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link('extension/extension', 'type=payment&token=' . $this->session->data['token'], 'SSL');


        // 接收商户号
        if (isset($this->request->post['globepayalipay_account'])) {
            $data['globepayalipay_account'] = $this->request->post['globepayalipay_account'];
        } else {
            $data['globepayalipay_account'] = $this->config->get('globepayalipay_account');
        }
        // 接收商户key
        if (isset($this->request->post['globepayalipay_secret'])) {
            $data['globepayalipay_secret'] = $this->request->post['globepayalipay_secret'];
        } else {
            $data['globepayalipay_secret'] = $this->config->get('globepayalipay_secret');
        }

        if (isset($this->request->post['globepayalipay_license_id'])) {
            $data['globepayalipay_license_id'] = $this->request->post['globepayalipay_license_id'];
        } else {
            $data['globepayalipay_license_id'] = $this->config->get('globepayalipay_license_id');
        }


        if (isset($this->request->post['globepayalipay_order_status_id'])) {
            $data['globepayalipay_order_status_id'] = $this->request->post['globepayalipay_order_status_id'];
        } else {
            $data['globepayalipay_order_status_id'] = $this->config->get('globepayalipay_order_status_id');
        }

        if (isset($this->request->post['globepayalipay_order_succeed_status_id'])) {
            $data['globepayalipay_order_succeed_status_id'] = $this->request->post['globepayalipay_order_succeed_status_id'];
        } else {
            $data['globepayalipay_order_succeed_status_id'] = $this->config->get('globepayalipay_order_succeed_status_id');
        }
        if(empty($data['globepayalipay_order_succeed_status_id'])){
            $data['globepayalipay_order_succeed_status_id']=2;
        }
        if (isset($this->request->post['globepayalipay_order_failed_status_id'])) {
            $data['globepayalipay_order_failed_status_id'] = $this->request->post['globepayalipay_order_failed_status_id'];
        } else {
            $data['globepayalipay_order_failed_status_id'] = $this->config->get('globepayalipay_order_failed_status_id');
        }
        if(empty($data['globepayalipay_order_failed_status_id'])){
            $data['globepayalipay_order_failed_status_id']=10;
        }
        if (isset($this->request->post['globepayalipay_order_payWait_status_id'])) {
            $data['globepayalipay_order_payWait_status_id'] = $this->request->post['globepayalipay_order_payWait_status_id'];
        } else {
            $data['globepayalipay_order_payWait_status_id'] = $this->config->get('globepayalipay_order_payWait_status_id');
        }

        $this->load->model('localisation/order_status');

        $data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

        if (isset($this->request->post['globepayalipay_geo_zone_id'])) {
            $data['globepayalipay_geo_zone_id'] = $this->request->post['globepayalipay_geo_zone_id'];
        } else {
            $data['globepayalipay_geo_zone_id'] = $this->config->get('globepayalipay_geo_zone_id');
        }

        $this->load->model('localisation/geo_zone');

        $data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        if (isset($this->request->post['globepayalipay_status'])) {
            $data['globepayalipay_status'] = $this->request->post['globepayalipay_status'];
        } else {
            $data['globepayalipay_status'] = $this->config->get('globepayalipay_status');
        }

        if (isset($this->request->post['globepayalipay_sort_order'])) {
            $data['globepayalipay_sort_order'] = $this->request->post['globepayalipay_sort_order'];
        } else {
            $data['globepayalipay_sort_order'] = $this->config->get('globepayalipay_sort_order');
        }

         $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/payment/globepayalipay', $data));
    }

    protected function validate()
    {
    if (! $this->user->hasPermission('modify', 'extension/payment/globepayalipay')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (! $this->request->post['globepayalipay_account']) {
            $this->error['account'] = $this->language->get('error_account');
        }

        if (! $this->request->post['globepayalipay_secret']) {
            $this->error['secret'] = $this->language->get('error_secret');
        }

        return ! $this->error;
    }
}
?>
