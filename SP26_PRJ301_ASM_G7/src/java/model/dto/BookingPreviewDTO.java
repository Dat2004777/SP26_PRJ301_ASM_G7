/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.dto;

import java.time.LocalDateTime;

/**
 *
 * @author ADMIN
 */
public class BookingPreviewDTO {
    private LocalDateTime timeIn;
    private LocalDateTime timeOut;
    private int vehicleTypeId;
    private int hours;
    private int basePrice;
    private int totalPrice;

    public BookingPreviewDTO() {
    }

    public BookingPreviewDTO( LocalDateTime timeIn, LocalDateTime timeOut, int vehicleTypeId, int hours, int basePrice, int totalPrice) {
        this.timeIn = timeIn;
        this.timeOut = timeOut;
        this.vehicleTypeId = vehicleTypeId;
        this.hours = hours;
        this.basePrice = basePrice;
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getTimeIn() {
        return timeIn;
    }

    public void setTimeIn(LocalDateTime timeIn) {
        this.timeIn = timeIn;
    }

    public LocalDateTime getTimeOut() {
        return timeOut;
    }

    public void setTimeOut(LocalDateTime timeOut) {
        this.timeOut = timeOut;
    }

    public int getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(int basePrice) {
        this.basePrice = basePrice;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getHours() {
        return hours;
    }

    public void setHours(int hours) {
        this.hours = hours;
    }

    public int getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(int vehicleTypeId) {
        this.vehicleTypeId = vehicleTypeId;
    }
    
    
}
