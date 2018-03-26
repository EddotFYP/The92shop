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
public class User {
    private String username;
    private String password;
    
    public User(String username,String password) {
        this.username = username;
        this.password = password;
    }
    
    /**
     * Get the value of Username
     *
     * @return the value of Username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Set the value of Username
     *
     * @param Username new value of Username
     */
    public void setUsername(String Username) {
        this.username = Username;
    }

    /**
     * Get the value of Password
     *
     * @return the value of Password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Set the value of Password
     *
     * @param password new value of Password
     */
    public void setPassword(String password) {
        this.password = password;
    }
    
    public boolean authenticate(String password){
        return password.equals(this.password);
    }
}
