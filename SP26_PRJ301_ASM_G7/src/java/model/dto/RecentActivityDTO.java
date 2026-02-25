package model.dto;

public class RecentActivityDTO {

    private String licensePlate;   // Biển số xe (VD: "30F-992.12")
    private String formattedTime;  // Thời gian hiển thị (VD: "10:42 AM")
    private String sessionState;

    public RecentActivityDTO(String licensePlate, String formattedTime, String sessionState) {
        this.licensePlate = licensePlate;
        this.formattedTime = formattedTime;
        this.sessionState = sessionState;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getSessionState() {
        return sessionState;
    }

    public void setSessionState(String sessionState) {
        this.sessionState = sessionState;
    }

    public String getFormattedTime() {
        return formattedTime;
    }

    public void setFormattedTime(String formattedTime) {
        this.formattedTime = formattedTime;
    }

}
