/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dto;

import model.Vehicle;

/**
 *
 * @author ADMIN
 */
public class VehicleBasePriceDTO {
    private Vehicle vehicle;
    private int basePrice;

    public VehicleBasePriceDTO(Vehicle vehicle, int basePrice) {
        this.vehicle = vehicle;
        this.basePrice = basePrice;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public int getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(int basePrice) {
        this.basePrice = basePrice;
    }
    
    
}
