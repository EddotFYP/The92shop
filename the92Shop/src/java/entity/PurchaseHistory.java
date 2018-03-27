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
    
    private int custId;
    
    private String dateOfPurchase;
    
    private int quantity;
    
    private int skuId;

    private int orderId;
    
    private String phone;
    
    private String productName;
    
    private double sales;

    public PurchaseHistory(int custId, String dateOfPurchase, int quantity, int skuId) {
        this.custId = custId;
        this.dateOfPurchase = dateOfPurchase;
        this.quantity = quantity;
        this.skuId = skuId;
    }
    
    public PurchaseHistory(int custId, String phone, int skuId, String dateOfPurchase, int quantity) {
        
        this.custId = custId;
        this.phone = phone;
        this.dateOfPurchase = dateOfPurchase;
        this.quantity = quantity;
        this.skuId = skuId;
    }
    
    public PurchaseHistory(int orderId, int custId, String phone, int skuId, String dateOfPurchase, int quantity) {
        this.orderId = orderId;
        this.custId = custId;
        this.phone = phone;
        this.dateOfPurchase = dateOfPurchase;
        this.quantity = quantity;
        this.skuId = skuId;
    }
    
    public PurchaseHistory(int skuId, String product_name, int quantity, double sales, String dateOfPurchase){
        this.skuId = skuId;
        this.productName = product_name;
        this.quantity = quantity;
        this.sales = sales;
        this.dateOfPurchase = dateOfPurchase;
    }
    
    /**
     * Get the value of skuId
     *
     * @return the value of skuId
     */
    public int getSkuId() {
        return skuId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public double getSales() {
        return sales;
    }

    /**
     * Set the value of skuId
     *
     * @param skuId new value of skuId
     */
    public void setSkuId(int skuId) {
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
    public int getCustId() {
        return custId;
    }

    /**
     * Set the value of custId
     *
     * @param custId new value of custId
     */
    public void setCustId(int custId) {
        this.custId = custId;
    }
    
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getPhoneNum() {
        return phone;
    }

    public void setPhoneNum(String phone) {
        this.phone = phone;
    }
    
}
