/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Jacquelyn
 */
public class InventoryPurchase {
    private int skuId;
    private int quantity;
    private String dateOfPurchase;
    private String name;
    
    
    public InventoryPurchase(int skuId, int quantity, String dateOfPurchase){
        this.skuId = skuId;
        this.quantity= quantity;
        this.dateOfPurchase = dateOfPurchase;
    }
    
     public InventoryPurchase(int skuId, String name, String dateOfPurchase, int quantity){
        this.name = name;
        this.skuId = skuId;
        this.quantity= quantity;
        this.dateOfPurchase = dateOfPurchase;
    }


    public int getSkuId() {
        return skuId;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getDateOfPurchase() {
        return dateOfPurchase;
    }
    
     public String getName(){
        return name;
    }
    public void setSkuId(int skuId) {
        this.skuId = skuId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setDateOfPurchase(String dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }
    
    
}
