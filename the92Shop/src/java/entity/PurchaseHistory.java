/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Clarey Liow JX
 */
public class PurchaseHistory {
    
    private String custId;
    
    private String dateOfPurchase;
    
    private int quantity;
    
    private String skuId;

    public PurchaseHistory(String custId, String dateOfPurchase, int quantity, String skuId) {
        this.custId = custId;
        this.dateOfPurchase = dateOfPurchase;
        this.quantity = quantity;
        this.skuId = skuId;
    }
    
    
    
    /**
     * Get the value of skuId
     *
     * @return the value of skuId
     */
    public String getSkuId() {
        return skuId;
    }

    /**
     * Set the value of skuId
     *
     * @param skuId new value of skuId
     */
    public void setSkuId(String skuId) {
        this.skuId = skuId;
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
     * Get the value of dateOfPurchase
     *
     * @return the value of dateOfPurchase
     */
    public String getDateOfPurchase() {
        return dateOfPurchase;
    }

    /**
     * Set the value of dateOfPurchase
     *
     * @param dateOfPurchase new value of dateOfPurchase
     */
    public void setDateOfPurchase(String dateOfPurchase) {
        this.dateOfPurchase = dateOfPurchase;
    }

    /**
     * Get the value of custId
     *
     * @return the value of custId
     */
    public String getCustId() {
        return custId;
    }

    /**
     * Set the value of custId
     *
     * @param custId new value of custId
     */
    public void setCustId(String custId) {
        this.custId = custId;
    }

}
