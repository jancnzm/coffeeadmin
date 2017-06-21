WxPay.appid = 'wx5726c31c9832f709'
WxPay.key = 'AEBF13D1B553259126B7FD74151CBB6E'
WxPay.mch_id = '1428913502'
WxPay.debug_mode = true # default is `true`
WxPay.appsecret = '444f198211e994eb81fb13b9cd4850a2'
WxPay.set_apiclient_by_pkcs12(File.read('/home/cert/posan/apiclient_cert.p12'), '1428913502')

WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}