using System;
using System.Net;
using System.Net.Mail;
using BusinessServices.Contract;

namespace BusinessServices
{
    public class EmailService : IEmailService
    {
        /// <summary>
        /// Send email using mail.xby2.com smtp server.
        /// </summary>
        /// <param name="to">Email address that you are sending the message to.</param>
        /// <param name="from">This value is not necessary, it is hard coded to contest@xby2.com.</param>
        /// <param name="subject">Subject line of email.</param>
        /// <param name="body">Body text of email.</param>
        /// <returns>True if sending the email succeeds, false if it fails. Currently no way to retrieve error message.</returns>
        public bool SendEmail(string to, string from, string subject, string body)
        {
            var message = new MailMessage();

            // Who we are sending to
            message.To.Add(to);

            message.From = new MailAddress(@"contest@xby2.com");


            message.Subject = subject;
            message.Body = body;


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
