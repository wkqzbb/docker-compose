{application, 'rabbitmq_trust_store', [
	{description, "Client X.509 certificates trust store"},
	{vsn, "3.12.5"},
	{id, "v3.12.4-57-g54ec903"},
	{modules, ['rabbit_trust_store','rabbit_trust_store_app','rabbit_trust_store_certificate_provider','rabbit_trust_store_file_provider','rabbit_trust_store_http_provider','rabbit_trust_store_sup']},
	{registered, [rabbitmq_trust_store_sup]},
	{applications, [kernel,stdlib,ssl,crypto,public_key,inets,rabbit_common,rabbit]},
	{mod, {rabbit_trust_store_app, []}},
	{env, [
	    {default_refresh_interval, 30},
	    {providers, [rabbit_trust_store_file_provider]}
	  ]}
]}.