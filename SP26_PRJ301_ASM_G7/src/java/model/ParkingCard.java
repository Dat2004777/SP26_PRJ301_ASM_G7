package model;

public class ParkingCard {
    
    public enum Status {
        AVAILABLE,  
        USING,     
//        LOST,       
//        BROKEN     
    }

    private String cardId;
    private String siteId; 
    private Status status;

    public ParkingCard() {
    }

    public ParkingCard(String cardId, String siteId, Status status) {
        this.cardId = cardId;
        this.siteId = siteId;
        this.status = status;
    }

    public String getCardId() { return cardId; }
    public void setCardId(String cardId) { this.cardId = cardId; }

    public String getSiteId() { return siteId; }
    public void setSiteId(String siteId) { this.siteId = siteId; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
}