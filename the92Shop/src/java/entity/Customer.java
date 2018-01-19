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
public class Customer {

    private String name;
    private String gender;
    private String birthDate;
    private String phoneNum;
    private String address;
    private String postalCode;
    private String custId;

    public Customer(String custId, String name, String gender, String birthDate, String phoneNum, String address, String postalCode) {
        this.custId = custId;
        this.name = name;
        this.gender = gender;
        this.birthDate = birthDate;
        this.phoneNum = phoneNum;
        this.address = address;
        this.postalCode = postalCode;
        
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
     * Get the value of gender
     *
     * @return the value of gender
     */
    public String getGender() {
        return gender;
    }

    /**
     * Set the value of gender
     *
     * @param gender new value of gender
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * Get the value of birthDate
     *
     * @return the value of birthDate
     */
    public String getBirthDate() {
        return birthDate;
    }

    /**
     * Set the value of birthDate
     *
     * @param birthDate new value of birthDate
     */
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    
    /**
     * Get the value of phoneNum
     *
     * @return the value of phoneNum
     */
    public String getPhoneNum() {
        return phoneNum;
    }

    /**
     * Set the value of birthDate
     *
     * @param phoneNum new value of phoneNum
     */
    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
    
    /**
     * Get the value of address
     *
     * @return the value of address
     */
    public String getAddress() {
        return address;
    }

    /**
     * Set the value of address
     *
     * @param address new value of address
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * Get the value of postalCode
     *
     * @return the value of postalCode
     */
    public String getPostalCode() {
        return postalCode;
    }

    /**
     * Set the value of postalCode
     *
     * @param postalCode new value of postalCode
     */
    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

   

}
