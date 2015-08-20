namespace BusinessServices.Contract
{
    public interface IEmailService
    {
        /// <summary>
        /// Send email using mail.xby2.com smtp server.
        /// </summary>
        /// <param name="to">Email address that you are sending the message to.</param>
        /// <param name="from">This value is not necessary, it is hard coded to contest@xby2.com.</param>
        /// <param name="subject">Subject line of email.</param>
        /// <param name="body">Body text of email.</param>
        /// <returns>True if sending the email succeeds, false if it fails. Currently no way to retrieve error message.</returns>
        bool SendEmail(string to, string from, string subject, string body);
    }
}
