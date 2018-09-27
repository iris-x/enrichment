from aiohttp import web
from aiohttp_swagger import setup_swagger, swagger_path
from iris.nlp import Document, ElasticIndex

routes = web.RouteTableDef()

platsannonser = ElasticIndex('https://elastic:mezzanine@omegateam.se:9200', index='platsannonser')

@swagger_path("swagger.yaml")
@routes.get('/platsannonser/{uuid}')
async def get_platsannons(request):

    uuid = request.match_info['uuid']

    print('get_platsannons: ', uuid)

    platsannons = platsannonser.get_by_ids(['2e378b60-828e-33a5-b85b-ae9664871b59'])

    #response = str(platsannons)
    return web.json_response(platsannons)


if __name__ == "__main__":
    Document('')
    app = web.Application()
    app.add_routes(routes)
    setup_swagger(app)
    web.run_app(app)



