﻿using System;
using System.Net;
using System.Net.Mail;
using BusinessServices.Contract;

namespace BusinessServices
{
    public class EmailService : IEmailService
    {
        public bool SendEmail(string to, string from, string subject, string body)
        {
            var message = new MailMessage();

            // Who we are sending to
            message.To.Add(@"mhussain@xby2.com");

            message.From = new MailAddress(@"<USERNAME>@xby2.com");


            message.Subject = @"You're not actually that cool.";
            message.Body = @"Click this: http://bit.ly/IqT6zt.";


            // Need credentials to send from xby2 domain
            // TODO: Setup a new email account for "contest@xby2.com" with password "contest_password"
            var smtp = new SmtpClient(@"mail.xby2.com");
            smtp.Credentials = new NetworkCredential("contest@xby2.com", "contest_password", "mail.xby2.com");
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = true;


            // Attempt to send
            try
            {
                smtp.Send(message);
            }
            catch (Exception e)
            {
                return false;
            }

            return true;
        }
    }
}
