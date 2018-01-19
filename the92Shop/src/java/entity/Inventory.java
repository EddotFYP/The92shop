/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Brendo Austin
 */
public class Inventory {
    
    private String skuID;
    private String name;
    private int quantity;
    private Date dateOfPurchase;
    private double costPrice;
    private double sellingPrice;

    public Inventory(String skuID, String name, int quantity, Date dateOfPurchase, double costPrice, double sellingPrice) {
        this.skuID = skuID;
        this.name = name;
        this.quantity = quantity;
        this.dateOfPurchase = dateOfPurchase;
        this.costPrice = costPrice;
        this.sellingPrice = sellingPrice;
        
    }
    
    /**
     * Get the value of name
     *
     * @return the value of name
     */
    public String getName() {
        return name;
    }

    /**
     * Set the value of name
     *
     * @param name new value of name
     */
    public void setName(String name) {
        this.name = name;
    }
    

     /**
     * Get the value of skuID
     *
     * @return the value of skuID
     */
    public String getSKUID() {
        return skuID;
    }

    /**
     * Set the value of skuID
     *
     * @param skuID new value of skuID
     */
    public void setSKUId(String skuID) {
        this.skuID = skuID;
    }
    
    /**
     * Get the value of quantity
     *
     * @return the value of quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Set the value of quantity
     *
     * @param quantity new value of quantity
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Get the value of date
     *
     * @return the value of date
     */
    public Date getPurchaseDate() {
        return dateOfPurchase;
    }

    /**
     * Set the value of dateOfPurchase
     *
     * @param dateOfPurchase new value of dateOfPurchase
     */
    public void setDate(Date dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }

    /**
     * Get the value of costPrice
     *
     * @return the value of costPrice
     */
    public double getCostPrice() {
        return costPrice;
    }

    /**
     * Set the value of costPrice
     *
     * @param costPrice new value of costPrice
     */
    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    /**
     * Get the value of sellingPrice
     *
     * @return the value of sellingPrice
     */
    public double getSellingPrice(){
        return sellingPrice;
    }

    /**
     * Set the value of sellingPrice
     *
     * @param sellingPrice new value of sellingPrice
     */
    public void setSellingPrice(double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

   

}
