{application, 'rabbitmq_federation_management', [
	{description, "RabbitMQ Federation Management"},
	{vsn, "3.12.5"},
	{id, "v3.12.4-57-g54ec903"},
	{modules, ['rabbit_federation_mgmt']},
	{registered, []},
	{applications, [kernel,stdlib,amqp_client,rabbit_common,rabbit,rabbitmq_management,rabbitmq_federation]},
	{env, []},
		{broker_version_requirements, []}
]}.