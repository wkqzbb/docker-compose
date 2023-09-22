{application, 'rabbitmq_peer_discovery_aws', [
	{description, "AWS-based RabbitMQ peer discovery backend"},
	{vsn, "3.12.5"},
	{id, "v3.12.4-57-g54ec903"},
	{modules, ['rabbit_peer_discovery_aws','rabbitmq_peer_discovery_aws']},
	{registered, []},
	{applications, [kernel,stdlib,inets,rabbit_common,rabbitmq_peer_discovery_common,rabbitmq_aws,rabbit]},
	{env, []}
]}.