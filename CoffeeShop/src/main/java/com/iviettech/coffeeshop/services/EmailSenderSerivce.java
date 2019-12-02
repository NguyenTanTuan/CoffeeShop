/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.services;

import com.iviettech.coffeeshop.controller.ShopController;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class EmailSenderSerivce {

    @Autowired
    private JavaMailSender jvs;
    @Autowired
    private ServletContext context;

    public void sendMail(String email, String fileForSend, String pathToResources, String content) {

        fileForSend += "emailTemplate.html";

        StringBuilder textHtml = new StringBuilder();
        File f = new File(context.getRealPath(fileForSend));
        try (
                BufferedReader reader = new BufferedReader(
                        new InputStreamReader(
                                new FileInputStream(f), "UTF-8"));) {

            String line;
            int check = 1;
            while ((line = reader.readLine()) != null) {
                //Custom name at Line 35
                if (check == 2) {
                    textHtml.append(content);
                } else {
                    textHtml.append(line);
                }
                check++;
            }
            MyPreparator preparator = new MyPreparator(email, textHtml, pathToResources);
            jvs.send(preparator);
            textHtml = new StringBuilder();
        } catch (Exception ex) {
            Logger.getLogger(ShopController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    class MyPreparator implements MimeMessagePreparator {

        private String email;
        private StringBuilder textHtml;
        private String pathToResources;

        public MyPreparator(String email, StringBuilder textHtml, String pathToResources) {
            this.email = email;
            this.textHtml = textHtml;
            this.pathToResources = pathToResources;
        }

        @Override
        public void prepare(MimeMessage mm) throws Exception {
            MimeMessageHelper helper = new MimeMessageHelper(mm, true, "UTF-8");
            helper.setSubject("Teaffe shop");
            helper.setTo(email);
            helper.setText(textHtml.toString(), true);
            // Get image from resources
            String pathUrl = context.getRealPath("/images");
            int index = pathUrl.indexOf("target");
            String pathImage = pathUrl.substring(0, index) + pathToResources + "/images/email/logo.jpg";

            //attach image into html
            helper.addInline("logoHeader", new File(pathImage));
        }

    }
}
