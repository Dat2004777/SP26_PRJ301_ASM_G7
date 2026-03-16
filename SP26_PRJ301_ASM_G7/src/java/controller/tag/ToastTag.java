package controller.tag;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class ToastTag extends SimpleTagSupport {

    private String type; // success, error, warning
    private String message;

    public void setType(String type) { this.type = type; }
    public void setMessage(String message) { this.message = message; }

    @Override
    public void doTag() throws JspException, IOException {
        if (message == null || message.trim().isEmpty()) {
            return;
        }

        JspWriter out = getJspContext().getOut();

        // 1. Logic xử lý màu sắc và Icon tương tự đoạn JS của bạn
        String borderColor = "#ffc107"; // Mặc định là Warning
        String iconClass = "bi-exclamation-circle-fill text-warning";

        if ("success".equalsIgnoreCase(type)) {
            borderColor = "#198754";
            iconClass = "bi-check-circle-fill text-success";
        } else if ("error".equalsIgnoreCase(type)) {
            borderColor = "#dc3545";
            iconClass = "bi-exclamation-triangle-fill text-danger";
        }

        StringBuilder sb = new StringBuilder();

        // 2. Nhúng CSS của bạn (Khuyên dùng: Bạn nên copy đoạn <style> này bỏ vào file CSS tổng của dự án để code Java gọn hơn)
        sb.append("<style>");
        sb.append(".custom-toast { border-radius: 10px !important; border-left: 4px solid transparent; background-color: #ffffff; min-width: 300px; transition: none !important; }");
        sb.append(".custom-toast .btn-close { font-size: 0.65rem; padding: 0.5rem; margin: 0.25rem; }");
        sb.append("@keyframes slideInFromRight { 0% { transform: translateX(120%); opacity: 0; } 100% { transform: translateX(0); opacity: 1; } }");
        sb.append(".custom-toast.show { animation: slideInFromRight 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards; }");
        sb.append("@media (max-width: 575.98px) {");
        sb.append("  .toast-container { width: 100%; padding: 1rem !important; top: 0 !important; bottom: auto !important; right: 0 !important; left: 0 !important; }");
        sb.append("  .custom-toast { width: 100%; max-width: 100%; }");
        sb.append("  @keyframes slideDownFromTop { 0% { transform: translateY(-100%); opacity: 0; } 100% { transform: translateY(0); opacity: 1; } }");
        sb.append("  .custom-toast.show { animation: slideDownFromTop 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards; }");
        sb.append("}");
        sb.append("</style>");

        // 3. Khối HTML Container & Toast theo đúng form của bạn
        // Lưu ý: Đã inject thẳng biến borderColor vào style và iconClass vào thẻ <i>
        sb.append("<div class='toast-container position-fixed top-0 end-0 p-4' style='z-index: 1055;'>");
        sb.append("  <div id='javaAutoToast' class='toast custom-toast shadow-lg' role='alert' aria-live='assertive' aria-atomic='true' style='border-left-color: ").append(borderColor).append(";'>");
        sb.append("    <div class='d-flex align-items-start py-2 px-3 bg-white' style='border-radius: 0 10px 10px 0;'>");
        sb.append("      <i class='bi fs-5 me-2 mt-1 ").append(iconClass).append("'></i>");
        sb.append("      <div class='flex-grow-1 pe-3'>");
        sb.append("        <span style='font-size: 0.9rem; line-height: 1.3; display: block;' class='mt-1 fw-medium text-dark'>");
        sb.append("          ").append(message);
        sb.append("        </span>");
        sb.append("      </div>");
        sb.append("      <button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>");
        sb.append("    </div>");
        sb.append("  </div>");
        sb.append("</div>");

        // 4. Đoạn JS để tự động kích hoạt Toast show lên 10 giây (10000ms)
        sb.append("<script>");
        sb.append("  document.addEventListener('DOMContentLoaded', function () {");
        sb.append("    const toastEl = document.getElementById('javaAutoToast');");
        sb.append("    if(toastEl) {");
        sb.append("       const bsToast = new bootstrap.Toast(toastEl, { delay: 10000 });");
        sb.append("       bsToast.show();");
        sb.append("    }");
        sb.append("  });");
        sb.append("</script>");

        out.print(sb.toString());
    }
}