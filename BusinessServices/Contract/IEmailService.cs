namespace BusinessServices.Contract
{
    public interface IEmailService
    {
        bool SendEmail(string to, string from, string subject, string body);
    }
}
