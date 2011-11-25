using FluentNHibernate.Mapping;

namespace KnowYourTurf.Core.Domain.Persistence
{
    public sealed class UserPersistenceMap : DomainEntityMap<User>
    {
        public UserPersistenceMap()
        {
            Map(u => u.FirstName);
            Map(u => u.LastName);
            Map(u => u.Email);
            Map(u => u.PhoneMobile);
            Map(u => u.PhoneHome);
            Map(u => u.Address1);
            Map(u => u.Address2);
            Map(u => u.City);
            Map(u => u.State);
            Map(u => u.ZipCode);
            Map(c => c.BirthDate);
            Map(c => c.Notes);
            Map(c => c.LanguageDefault);
            Map(x => x.ImageUrl);
            Map(x => x.EmergencyContact);
            Map(x => x.EmergencyContactPhone);
            Map(x => x.EmployeeId);
            References(x => x.Company);
            References(x => x.UserLoginInfo);
            HasManyToMany(x => x.GetEmailTemplates()).Access.CamelCaseField(Prefix.Underscore).LazyLoad().Cascade.SaveUpdate();
        }

        public class UserLoginInfoMap : DomainEntityMap<UserLoginInfo>
        {
            public UserLoginInfoMap()
            {
                Map(x => x.LoginName);
                Map(x => x.Password);
                Map(x => x.Status);
                Map(x => x.UserRoles);
                Map(x => x.UserType);
            }
        }
    }
}