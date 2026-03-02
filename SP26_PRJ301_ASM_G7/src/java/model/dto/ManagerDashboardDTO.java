/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dto;
import model.ParkingSite;

/**
 *
 * @author dat20
 */
public class ManagerDashboardDTO {

    private long totalAmount;
    private int currentParkedVehicles;
    private int totalSubscription;
    private ParkingSite activeSites;

    public ManagerDashboardDTO() {
    }

    public ManagerDashboardDTO (long totalAmount, int currentParkedVehicles, int totalSubscription, ParkingSite allActiveSites) {
        this.totalAmount = totalAmount;
        this.currentParkedVehicles = currentParkedVehicles;
        this.totalSubscription = totalSubscription;
        this.activeSites = allActiveSites;
    }

    public long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getCurrentParkedVehicles() {
        return currentParkedVehicles;
    }

    public void setCurrentParkedVehicles(int currentParkedVehicles) {
        this.currentParkedVehicles = currentParkedVehicles;
    }

    public int getTotalSubscription() {
        return totalSubscription;
    }

    public void setTotalSubscription(int totalSubscription) {
        this.totalSubscription = totalSubscription;
    }

    public ParkingSite getActiveSites() {
        return activeSites;
    }

    public void setActiveSites(ParkingSite activeSites) {
        this.activeSites = activeSites;
    }

}