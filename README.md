Step:

1. Edit config.yml to set the right configuration

2. Load all deas ip addresses:
   ./client load_vms

3. Upload benchmark binaries and configuration to deas:
   ./client upload

4. Provision instances on specified node:
  ./client provision redis_node_100_0 30 # Provision 30 instances in redis_node_100_0

5. Copy node local_db to local:
  ./client local_db

6. Add pre load to specified node:
  ./client preload

7. Run density test:
  ./client run

8. Stop density test:
  ./client stop

9. Get response time:
  ./client response_time

10. Clean collected data:
  ./client clean

11. Unprovision instances on specified node:
  ./client unprovision redis_node_100_0
