import asyncio
import json
import config
from elasticsearch import Elasticsearch
from hpfeeds.asyncio import ClientSession



async def main():
    es = Elasticsearch([{'host': config.ipElastic,
                       'port': config.portElastic}])
    i = 1
    async with ClientSession(
            config.ipBroker, config.portBroker,
            config.ident, config.secret) as client:
        client.subscribe(config.channels)

        async for ident, channel, payload in client:
            payload = payload.decode('utf-8')
            es.index(index='test',
                     doc_type='hydra', id=i, body=json.loads(str(payload)))
            i = i + 1


loop = asyncio.get_event_loop()
loop.run_until_complete(main())