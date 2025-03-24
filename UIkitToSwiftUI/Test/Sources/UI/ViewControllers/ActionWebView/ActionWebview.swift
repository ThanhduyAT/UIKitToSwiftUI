import UIKit
import WebKit

class ActionWebviewVC: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Khởi tạo WKWebView
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "linkHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        
        webView = WKWebView(frame: self.view.bounds, configuration: config)
//        webView.navigationDelegate = self // Đặt delegate
        self.view.addSubview(webView)

        // Tạo nội dung HTML với một liên kết
//        let htmlContent = """
//        <html>
//        <body>
//        <a href="https://vnexpress.net/ai-tao-sinh-cuoc-dua-dot-tien-4583275.html">AI tạo sinh</a>
//        </body>
//        </html>
//        """
        let htmlContent = """
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>body { margin:0; padding:0; pointer-events: none!important} img{display: inline;height: auto;max-width: 100%;} p { font-size: 16px} h6{ font-size: 16px} h5{ font-size: 18px} h4{ font-size: 20px} h3{ font-size: 22px} h2{ font-size: 24px} h1{ font-size: 30px}</style><h1 class="title-detail">2023 - năm AI phổ cập mọi nh&agrave;</h1>
        <p class="description">2023 đ&aacute;nh dấu AI kh&ocirc;ng c&ograve;n b&oacute; hẹp trong cộng đồng nhỏ, m&agrave; ứng dụng rộng khắp để phục vụ h&agrave;ng triệu người Việt, từ viết văn đến tạo ảnh avatar.</p>
        <article class="fck_detail ">
        <p class="Normal">OpenAI c&ocirc;ng bố ChatGPT - <a href="https://vnexpress.net/ai-tao-sinh-cuoc-dua-dot-tien-4583275.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-AiTaoSinh&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">AI tạo sinh</a> hoạt động dựa tr&ecirc;n m&ocirc; h&igrave;nh ng&ocirc;n ngữ lớn (LLM), được đ&agrave;o tạo để thực hiện cuộc tr&ograve; chuyện như người thật - v&agrave;o cuối 2022 v&agrave; bắt đầu b&ugrave;ng nổ đầu năm nay. Ngay sau đ&oacute;, nhiều h&atilde;ng c&ocirc;ng nghệ lớn cũng cho ra mắt chatbot tương tự như Google với Bard, Microsoft c&oacute; Bing Chat, xAI với Grok, Baidu với Ernie Bot.</p>
        <p class="Normal">Sự xuất hiện của AI tạo sinh gi&uacute;p x&oacute;a bỏ h&igrave;nh ảnh về c&aacute;c trợ l&yacute; tr&iacute; tuệ nh&acirc;n tạo tẻ nhạt, k&eacute;m linh hoạt tồn tại h&agrave;ng chục năm. Từ một c&ocirc;ng nghệ phức tạp, tr&iacute; tuệ nh&acirc;n tạo trở th&agrave;nh c&ocirc;ng cụ trực quan, dễ tiếp cận, mở ra h&agrave;ng loạt xu hướng ứng dụng v&agrave;o đời sống. Trong b&aacute;o c&aacute;o xu hướng t&igrave;m kiếm nổi bật tại Việt Nam 2023, Google đ&aacute;nh gi&aacute; AI đ&atilde; trở th&agrave;nh chủ đề n&oacute;ng. "Sự cạnh tranh của nhiều c&ocirc;ng ty c&ocirc;ng nghệ h&agrave;ng đầu nhằm đưa ứng dụng AI tiếp cận người d&ugrave;ng cuối đ&atilde; thu h&uacute;t sự ch&uacute; &yacute; lớn v&agrave; dẫn đến sự phổ biến của những từ kh&oacute;a li&ecirc;n quan đến AI tr&ecirc;n Google Search 2023", b&aacute;o c&aacute;o n&ecirc;u. Trong đ&oacute;, người Việt quan t&acirc;m đến "lợi &iacute;ch của AI", "ng&agrave;nh học AI c&oacute; g&igrave;" hay c&aacute;ch ứng dụng AI v&agrave;o c&aacute;c lĩnh vực cụ thể.</p>
        <p class="Normal"><strong>AI tạo sinh trong c&ocirc;ng việc v&agrave; giải tr&iacute;</strong></p>
        <p class="Normal">Ngay từ th&aacute;ng 1, khi OpenAI chưa hỗ trợ đăng k&yacute; tại Việt Nam, nhiều người đ&atilde; t&igrave;m c&aacute;ch tạo hoặc mua t&agrave;i khoản để trải nghiệm <a href="https://vnexpress.net/chu-de/chatgpt-5974" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-Chatgpt&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">ChatGPT</a>. Tận dụng khả năng tiếp nhận, xử l&yacute; v&agrave; diễn đạt nội dung dưới dạng văn bản của AI, người d&ugrave;ng c&oacute; thể viết luận, l&agrave;m thơ, t&oacute;m tắt b&aacute;o c&aacute;o, thậm ch&iacute; s&aacute;ng t&aacute;c t&aacute;c phẩm văn học v&agrave; viết b&aacute;o.</p>
        <p class="Normal" style="text-align: center;"><strong><a href="https://vnexpress.net/con-sot-chatgpt-tai-viet-nam-4565326.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-ConSotChatgptTaiVietNam&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">Cơn sốt ChatGPT tại Việt Nam</a></strong></p>
        <figure class="tplCaption action_thumb_added" data-size="true">
        <div class="fig-picture" style="padding-bottom: 60%; position: relative;"><picture data-inimage="done"> <source srcset="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg 1x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=LMNlgsgVtxvZ6g6GePqoYw 1.5x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=qOC2YVfyowKIG6Tx2VHxdg 2x" data-srcset="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg 1x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=LMNlgsgVtxvZ6g6GePqoYw 1.5x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=qOC2YVfyowKIG6Tx2VHxdg 2x"> <img class="lazy loading" style="position: absolute; width: 100%; left: 0;" src="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg" alt="Giao diện ChatGPT tr&ecirc;n điện thoại. Ảnh: Lưu Qu&yacute;" loading="lazy" data-src="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg" data-ll-status="loading"></picture>
        <div class="embed-container-ads" style="display: block; width: 100%; padding-bottom: 0px !important; margin-bottom: 0px !important; background: transparent; overflow: hidden; float: left; height: 100px; position: absolute; bottom: -1px;">
        <div id="sis_inimage" style="position: relative; width: 100%; height: 100%; text-align: center;" data-google-query-id="CJv6ju3cmIMDFQ5NwgUd94wFJw">
        <div id="google_ads_iframe_/27973503/Vnexpress/Desktop/Inimage/Sohoa/Sohoa.congnghe.detail_0__container__" style="border: 0pt none;"><iframe id="google_ads_iframe_/27973503/Vnexpress/Desktop/Inimage/Sohoa/Sohoa.congnghe.detail_0" style="border: 0px none; vertical-align: bottom;" tabindex="0" title="3rd party ad content" role="region" name="google_ads_iframe_/27973503/Vnexpress/Desktop/Inimage/Sohoa/Sohoa.congnghe.detail_0" width="1" height="1" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" aria-label="Advertisement" data-google-container-id="5" data-load-complete="true"></iframe></div>
        </div>
        </div>
        </div>
        <figcaption>
        <p class="Image">Giao diện ChatGPT tr&ecirc;n điện thoại. Ảnh: <em>Lưu Qu&yacute;</em></p>
        </figcaption>
        </figure>
        <p class="Normal">Tại trường học, chatbot được cả gi&aacute;o vi&ecirc;n v&agrave; học sinh sử dụng như <a href="https://vnexpress.net/giao-vien-hoc-sinh-thich-thu-trai-nghiem-chatgpt-4565643.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-CongCuHoTro&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">c&ocirc;ng cụ hỗ trợ</a> ở c&aacute;c m&ocirc;n cần t&oacute;m tắt lượng lớn th&ocirc;ng tin. Trong khi đ&oacute;, chỉ bằng v&agrave;i từ kh&oacute;a gợi &yacute; cho AI, l&atilde;nh đạo tổ chức, doanh nghiệp c&oacute; thể chuẩn bị những b&agrave;i ph&aacute;t biểu trước nh&acirc;n vi&ecirc;n với văn phong ph&ugrave; hợp.</p>
        <p class="Normal">Một số nh&agrave; văn Việt Nam cho biết từng d&ugrave;ng ChatGPT để <a href="https://vnexpress.net/chatgpt-chua-the-de-doa-gioi-van-chuong-4596097.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-BienSoanMucLuc&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">bi&ecirc;n soạn mục lục</a> v&agrave; tư duy đề t&agrave;i. D&ugrave; chưa thể s&aacute;ng tạo c&acirc;u chữ gi&agrave;u cảm x&uacute;c như con người, AI vẫn được đ&aacute;nh gi&aacute; l&agrave; trợ thủ gi&uacute;p tiết kiệm đ&aacute;ng kể thời gian lao động.</p>
        <div id="sis_outstream__c" data-set="dfp"></div>
        <p class="Normal">Ngo&agrave;i ra, nhiều người c&ograve;n d&ugrave;ng chatbot để <a href="https://vnexpress.net/dung-sieu-ai-tra-cuu-viet-van-thay-cho-google-4558073.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-TraCuuThongTin&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">tra cứu th&ocirc;ng tin</a> thay cho việc t&igrave;m kiếm qua Google, Bing Search. Một số dịch giả cho rằng khả năng chuyển ngữ của AI tạo sinh hiệu quả hơn c&aacute;c ứng dụng chuy&ecirc;n về dịch thuật. Nguy&ecirc;n nh&acirc;n l&agrave; thay v&igrave; dịch từng từ, cụm từ, c&ocirc;ng cụ AI c&oacute; thể hiểu ngữ cảnh b&agrave;i viết, từ đ&oacute; đưa ra c&aacute;ch diễn đạt lưu lo&aacute;t, dễ hiểu nhất. V&agrave;o th&aacute;ng 9, một ứng dụng dịch thuật của hai du học sinh Việt đ&atilde; nhận khoản đầu tư h&agrave;ng chục tỷ đồng tại Mỹ, nhờ kết hợp AI để chuyển văn bản tiếng Việt th&agrave;nh tiếng Anh c&ugrave;ng 100 ng&ocirc;n ngữ kh&aacute;c nhau.</p>
        <p class="Normal"><strong>Xu hướng d&ugrave;ng AI tạo ảnh</strong></p>
        <p class="Normal">Mở đầu 2023, bộ ảnh <a href="https://vnexpress.net/linh-vat-meo-do-ai-ve-bi-nham-la-meo-ninh-thuan-4561272.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-LinhVatMeo&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">linh vật m&egrave;o</a> g&acirc;y sốt mạng x&atilde; hội khi nhiều người tưởng đ&acirc;y l&agrave; tượng linh vật m&egrave;o ch&agrave;o năm mới ở tỉnh Ninh Thuận. Thực tế, ảnh được tạo bằng c&ocirc;ng cụ <a href="https://vnexpress.net/midjourney-ai-dung-sau-loat-anh-gia-gay-soc-4587973.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-Midjourney&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">Midjourney</a>.</p>
        <figure class="tplCaption action_thumb_added" data-size="true">
        <div class="fig-picture" style="padding-bottom: 100%; position: relative;"><picture> <source srcset="https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=5T_YHsRud86nMV2CRT0w9A 1x, https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=vJsePP00bUT4488v6AJCEg 1.5x, https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=UWM_3loZqXLDmF6epaaAEw 2x" data-srcset="https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=5T_YHsRud86nMV2CRT0w9A 1x, https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=vJsePP00bUT4488v6AJCEg 1.5x, https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=UWM_3loZqXLDmF6epaaAEw 2x"> <img class="lazy loading" style="position: absolute; width: 100%; left: 0;" src="https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=5T_YHsRud86nMV2CRT0w9A" alt="Ảnh do AI tạo bị nhầm l&agrave; tượng linh vật m&egrave;o Ninh Thuận. Ảnh:Bo Nguy&ecirc;n/Midjourney" loading="lazy" data-src="https://i1-sohoa.vnecdn.net/2023/12/18/AI-1-4859-1702868191.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=5T_YHsRud86nMV2CRT0w9A" data-ll-status="loading"> </picture></div>
        <figcaption>
        <p class="Image">Ảnh do AI tạo bị nhầm l&agrave; tượng linh vật m&egrave;o Ninh Thuận. Ảnh: <em>Bo Nguy&ecirc;n/Midjourney</em></p>
        </figcaption>
        </figure>
        <p class="Normal">Xu hướng sử dụng phần mềm <a href="https://vnexpress.net/hoa-si-viet-ai-ve-tranh-la-con-dao-hai-luoi-4549518.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-VeTranhAi&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">vẽ tranh AI</a> đ&atilde; xuất hiện từ 2022, nhưng chỉ xoay quanh một số hội nh&oacute;m đam m&ecirc; c&ocirc;ng nghệ. Tuy nhi&ecirc;n, c&ugrave;ng với sự b&ugrave;ng nổ của ChatGPT, <a href="https://vnexpress.net/loat-ai-bien-tri-tuong-tuong-thanh-hinh-anh-4589811.html" rel="dofollow" data-itm-source="#vn_source=Detail-SoHoa_CongNghe_Ai-4689421&amp;vn_campaign=Box-InternalLink&amp;vn_medium=Link-LoatCongCu&amp;vn_term=Desktop&amp;vn_thumb=0" data-itm-added="1">loạt c&ocirc;ng cụ</a> tạo ảnh được n&acirc;ng cấp v&agrave; thu h&uacute;t lượng lớn người d&ugrave;ng trong năm 2023. Chỉ bằng c&acirc;u lệnh ph&ugrave; hợp dưới dạng văn bản, ai cũng c&oacute; thể đ&oacute;ng vai họa sĩ để s&aacute;ng tạo theo nhiều phong c&aacute;ch, như tự thiết kế nội thất, thời trang, thậm ch&iacute; vẽ truyện tranh m&agrave; kh&ocirc;ng cần năng khiếu mỹ thuật.</p>
        </article>
        """
        
//        let htmlContent = """
//               <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
//               <style>
//                   body { margin:0; padding:0; }
//                   img { display: inline; height: auto; max-width: 100%; }
//                   p { font-size: 16px; }
//                   h6 { font-size: 16px; }
//                   h5 { font-size: 18px; }
//                   h4 { font-size: 20px; }
//                   h3 { font-size: 22px; }
//                   h2 { font-size: 24px; }
//                   h1 { font-size: 30px; }
//               </style>
//               <h1 class="title-detail">2023 - năm AI phổ cập mọi nh&agrave;</h1>
//               <p class="description">2023 đ&aacute;nh dấu AI kh&ocirc;ng c&ograve;n b&oacute; hẹp trong cộng đồng nhỏ, m&agrave; ứng dụng rộng khắp để phục vụ h&agrave;ng triệu người Việt, từ viết văn đến tạo ảnh avatar.</p>
//               <article class="fck_detail">
//                   <p class="Normal">OpenAI c&ocirc;ng bố ChatGPT - <a href="https://vnexpress.net/ai-tao-sinh-cuoc-dua-dot-tien-4583275.html">AI tạo sinh</a> hoạt động dựa tr&ecirc;n m&ocirc; h&igrave;nh ng&ocirc;n ngữ lớn (LLM), được đ&agrave;o tạo để thực hiện cuộc tr&ograve; chuyện như người thật - v&agrave;o cuối 2022 v&agrave; bắt đầu b&ugrave;ng nổ đầu năm nay. Ngay sau đ&oacute;, nhiều h&atilde;ng c&ocirc;ng nghệ lớn cũng cho ra mắt chatbot tương tự như Google với Bard, Microsoft c&oacute; Bing Chat, xAI với Grok, Baidu với Ernie Bot.</p>
//                   <p class="Normal">Sự xuất hiện của AI tạo sinh gi&uacute;p x&oacute;a bỏ h&igrave;nh ảnh về c&aacute;c trợ l&yacute; tr&iacute; tuệ nh&acirc;n tạo tẻ nhạt, k&eacute;m linh hoạt tồn tại h&agrave;ng chục năm. Từ một c&ocirc;ng nghệ phức tạp, tr&iacute; tuệ nh&acirc;n tạo trờ thành c&ocirc;ng cụ trực quan, dễ tiếp cận, mở ra h&agrave;ng loạt xu hướng ứng dụng v&agrave;o đời sống. Trong b&aacute;o c&aacute;o xu hướng t&igrave;m kiếm nổi bật tại Việt Nam 2023, Google đ&aacute;nh gi&aacute; AI đ&atilde; trở th&agrave;nh chủ đề n&oacute;ng. "Sự cạnh tranh của nhiều c&ocirc;ng ty c&ocirc;ng nghệ h&agrave;ng đầu nhằm đưa ứng dụng AI tiếp cận người d&ugrave;ng cuối đ&atilde; thu h&uacute;t sự ch&uacute; &yacute; lớn v&agrave; dẫn đến sự phổ biến của những từ kh&oacute;a li&ecirc;n quan đến AI tr&ecirc;n Google Search 2023", b&aacute;o c&aacute;o n&ecirc;u. Trong đ&oacute;, người Việt quan t&acirc;m đến "lợi &iacute;ch của AI", "ng&agrave;nh học AI c&oacute; g&igrave;" hay c&aacute;ch ứng dụng AI v&agrave;o c&aacute;c lĩnh vực cụ thể.</p>
//                   <p class="Normal"><strong>AI tạo sinh trong c&ocirc;ng việc v&agrave; giải tr&iacute;</strong></p>
//                   <p class="Normal">Ngay từ th&aacute;ng 1, khi OpenAI chưa hỗ trợ đăng k&yacute; tại Việt Nam, nhiều người đ&atilde; t&igrave;m c&aacute;ch tạo hoặc mua t&agrave;i khoản để trải nghiệm <a href="https://vnexpress.net/chu-de/chatgpt-5974">ChatGPT</a>. Tận dụng khả năng tiếp nhận, xử l&yacute; v&agrave; diễn đạt nội dung dưới dạng văn bản của AI, người d&ugrave;ng c&oacute; thể viết luận, l&agrave;m thơ, t&oacute;m tắt b&aacute;o c&aacute;o, thậm ch&iacute; s&aacute;ng t&aacute;c t&aacute;c phẩm văn học v&agrave; viết b&aacute;o.</p>
//                   <p class="Normal" style="text-align: center;"><strong><a href="https://vnexpress.net/con-sot-chatgpt-tai-viet-nam-4565326.html">Cơn sốt ChatGPT tại Việt Nam</a></strong></p>
//                   <figure class="tplCaption action_thumb_added" data-size="true">
//                       <div class="fig-picture" style="padding-bottom: 60%; position: relative;">
//                           <picture data-inimage="done">
//                               <source srcset="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg 1x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=LMNlgsgVtxvZ6g6GePqoYw 1.5x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=qOC2YVfyowKIG6Tx2VHxdg 2x" data-srcset="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg 1x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=1020&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=LMNlgsgVtxvZ6g6GePqoYw 1.5x, https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=2&amp;fit=crop&amp;s=qOC2YVfyowKIG6Tx2VHxdg 2x">
//                                   <img class="lazy loading" style="position: absolute; width: 100%; left: 0;" src="https://i1-sohoa.vnecdn.net/2023/12/15/chatgpt-222-4520-1675196490-2628-1702642757.jpg?w=680&amp;h=0&amp;q=100&amp;dpr=1&amp;fit=crop&amp;s=mREkAOOoZx-Pvg5VSylKEg" alt="Cơn sốt ChatGPT tại Việt Nam" title="Cơn sốt ChatGPT tại Việt Nam">
//                               </picture>
//                           </div>
//                           <figcaption class="fig-caption">Cơn sốt ChatGPT tại Việt Nam</figcaption>
//                       </div>
//                   </figure>
//               </article>
//               """
        
        // Load nội dung HTML vào WKWebView
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }

    // Xử lý các sự kiện điều hướng
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        print("decidePolicyFor called")
//        
//        if let url = navigationAction.request.url {
//            print("Link clicked: \(url.absoluteString)")
//            
//            // Ví dụ: Xử lý một URL cụ thể
//            if url.absoluteString == "https://vnexpress.net/ai-tao-sinh-cuoc-dua-dot-tien-4583275.html" {
//                print("Handling specific URL within the app")
//                
//                // Ví dụ: Chuyển đến một view controller khác hoặc thực hiện hành động trong ứng dụng
//                let specialViewController = SpecialViewController() // Thay thế bằng view controller của bạn
//                self.navigationController?.pushViewController(specialViewController, animated: true)
//                
//                // Hủy bỏ điều hướng trong WKWebView
//                decisionHandler(.cancel)
//                return
//            }
//        }
//
//        // Cho phép WKWebView tiếp tục điều hướng
//        decisionHandler(.allow)
//    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Received URL:")
        if message.name == "linkHandler" {
            if let urlString = message.body as? String, let url = URL(string: urlString) {
                // Xử lý URL ở đây
                print("Received URL: \(url)")
                // Ví dụ: mở URL trong ứng dụng
                UIApplication.shared.open(url)
            }
        }
    }
}

// Ví dụ về một view controller đặc biệt
class SpecialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "This is a special view controller."
        label.textAlignment = .center
        label.frame = view.bounds
        view.addSubview(label)
    }
}
