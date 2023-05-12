const request = require('supertest');
const app = require('./app');

describe('GET /', function() {
  it('responds with a message', function(done) {
    request(app)
      .get('/')
      .expect(200)
      .end(function(err, res) {
        if (err) return done(err);
        chai.expect(res.text).to.equal('Hello Jenkins, my main man!');
        done();
      });
  });
});
