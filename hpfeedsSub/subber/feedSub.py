import asyncio
import json
import config
from elasticsearch import Elasticsearch
from hpfeeds.asyncio import ClientSession



async def main():
    params = {'pipeline': 'cowrie'}
    es = Elasticsearch([{'host': config.ipElastic,
                       'port': config.portElastic}])
    async with ClientSession(
            config.ipBroker, config.portBroker,
            config.ident, config.secret) as client:
        client.subscribe(config.channels)

        async for ident, channel, payload in client:
            payload = payload.decode('utf-8')
            es.index(index='test', doc_type='hydra',
                     body=json.loads(str(payload)), params=params)


loop = asyncio.get_event_loop()
loop.run_until_complete(main())