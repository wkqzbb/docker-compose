{application, 'rabbitmq_peer_discovery_common', [
	{description, "Modules shared by various peer discovery backends"},
	{vsn, "3.12.5"},
	{id, "v3.12.4-57-g54ec903"},
	{modules, ['rabbit_peer_discovery_cleanup','rabbit_peer_discovery_common_app','rabbit_peer_discovery_common_sup','rabbit_peer_discovery_config','rabbit_peer_discovery_httpc','rabbit_peer_discovery_util']},
	{registered, [rabbitmq_peer_discovery_common_sup]},
	{applications, [kernel,stdlib,inets,rabbit_common,rabbit]},
	{mod, {rabbit_peer_discovery_common_app, []}},
	{env, []}
]}.