package model.dto;

public class RecentActivityDTO {
    private String licensePlate;   // Biển số xe (VD: "30F-992.12")
    private String actionName;     // Tên hành động (VD: "Xe vào bãi", "Xe ra bãi")
    private String formattedTime;  // Thời gian hiển thị (VD: "10:42 AM")
    private String dateLabel;      // Ngày (VD: "Hôm nay")
    
    // Thuộc tính phục vụ UI/UX (CSS Classes)
    private String iconClass;      // Icon hành động (VD: "bi-arrow-down-circle")
    private String badgeClass;     // Màu của Badge (VD: "bg-success-subtle text-success")
    private String badgeText;      // Chữ trong Badge (VD: "Đã duyệt", "Hoàn thành")
    private String textClass;      // Màu chữ của dòng thông báo (VD: "text-primary", "text-success")

    public RecentActivityDTO(String licensePlate, String actionName, String formattedTime, String dateLabel, String iconClass, String badgeClass, String badgeText, String textClass) {
        this.licensePlate = licensePlate;
        this.actionName = actionName;
        this.formattedTime = formattedTime;
        this.dateLabel = dateLabel;
        this.iconClass = iconClass;
        this.badgeClass = badgeClass;
        this.badgeText = badgeText;
        this.textClass = textClass;
    }

    // --- Generate Getters & Setters ở đây ---
    public String getLicensePlate() { return licensePlate; }
    public String getActionName() { return actionName; }
    public String getFormattedTime() { return formattedTime; }
    public String getDateLabel() { return dateLabel; }
    public String getIconClass() { return iconClass; }
    public String getBadgeClass() { return badgeClass; }
    public String getBadgeText() { return badgeText; }
    public String getTextClass() { return textClass; }
}