/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author dat20
 */
public class Card {

    private String cardId;
    private int siteId;
    private int totalCard;

    public Card() {
    }

    public Card(String cardId, int siteId, int totalCard) {
        this.cardId = cardId;
        this.siteId = siteId;
        this.totalCard = totalCard;
    }

    public String getCardId() {
        return cardId;
    }

    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public int getSiteId() {
        return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }

    public int getTotalCard() {
        return totalCard;
    }

    public void setTotalCard(int totalCard) {
        this.totalCard = totalCard;
    }
}
