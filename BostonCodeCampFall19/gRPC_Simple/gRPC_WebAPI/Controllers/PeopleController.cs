using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace gRPC_WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PeopleController : ControllerBase
    {
        // GET: api/People
        [HttpGet]
        public IEnumerable<Person> Get()
        {
            return GeneratePeople();
        }

        // GET: api/People/5
        [HttpGet("{id}", Name = "Get")]
        public Person Get(int id)
        {
            var ran = new Random(DateTime.Now.Second);
            return new Person
            {
                Id = id,
                FirstName = $"FN-{id}",
                LastName = $"LN-{id}",
                Age = ran.Next(15, 70)
            }; 
        }

        // POST: api/People
        [HttpPost]
        public void Post([FromBody] Person value)
        {
            return;
        }

        // PUT: api/People/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Person value)
        {
            return;
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            return;
        }

        private static IEnumerable<Person> GeneratePeople()
        {
            var ran = new Random(DateTime.Now.Second);
            var people = new List<Person>();
            for (var i = 1; i < 10; i++)
            {
                people.Add(
                    new Person
                    {
                        Id = i,
                        FirstName = $"FN-{i}",
                        LastName = $"LN-{i}",
                        Age = ran.Next(15, 70)
                    });
            }

            return people;
        }

        public class Person
        {
            public int Id { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public int Age { get; set; }
        }
    }
}
