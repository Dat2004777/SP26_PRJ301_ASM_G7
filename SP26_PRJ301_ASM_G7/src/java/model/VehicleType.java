/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class VehicleType {
    private int vehicleTypeId;
    private VehicleName vehicleName;
    
    public VehicleType(){
        
    }

    public VehicleType(int vehicleTypeId, VehicleName vehicleName) {
        this.vehicleTypeId = vehicleTypeId;
        this.vehicleName = vehicleName;
    }

    public int getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(int vehicleTypeId) {
        this.vehicleTypeId = vehicleTypeId;
    }

    public VehicleName getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(VehicleName vehicleName) {
        this.vehicleName = vehicleName;
    }
    
     public enum VehicleName {
        CAR("Ôtô"),
        MOTORBIKE("Xe máy");

        private final String label;

        private VehicleName(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }
}
