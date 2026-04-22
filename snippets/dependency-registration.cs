public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddCore(this IServiceCollection services)
    {
        services.AddScoped<IOrderApprovalService, OrderApprovalService>();
        services.AddScoped<IClock, SystemClock>();
        return services;
    }

    public static IServiceCollection AddInfrastructure(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddDbContext<AppDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("MainDb")));

        services.AddScoped<IOrderRepository, EfOrderRepository>();
        services.AddScoped<IMailSender, SmtpMailSender>();

        return services;
    }
}
