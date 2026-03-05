/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class ParkingCard {
    public enum State {
        AVAILABLE,  
        USING,  
        BOOKED
//        LOST,       
//        BROKEN     
    }

    private String cardId;
    private int siteId; 
    private State state;

    public ParkingCard() {
    }

    public ParkingCard(String cardId, int siteId, State state) {
        this.cardId = cardId;
        this.siteId = siteId;
        this.state = state;
    }

    public String getCardId() { return cardId; }
    public void setCardId(String cardId) { this.cardId = cardId; }

    public int getSiteId() { return siteId; }
    public void setSiteId(int siteId) { this.siteId = siteId; }

    public State getState() { return state; }
    public void setState(State state) { this.state = state; }
}
