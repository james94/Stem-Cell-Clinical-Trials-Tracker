// SJSU CMPE 138 Fall 2021 TEAM1
import React from "react";
import { Link, withRouter } from "react-router-dom";
import GrantsService from "../service/GrantsService";

class GrantsListPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      grants: [],
      researcher_id: localStorage.getItem("id"),
    };
  }

  render() {
    return (
      <div>
        <h2>Grant List</h2>
        {/* grants list */}
        <ul>
          {this.state.grants.map((e, i) => (
            <li key={i}>
              <Link to={{ pathname: `/grant/${e.grant_number}` }}>
                {e.grant_title}
              </Link>
            </li>
          ))}
        </ul>
      </div>
    );
  }

  // first page load, then rerenders
  componentDidMount() {
    let config = {
      headers: {
        researcher_id: this.state.researcher_id,
        list_all: true,
      },
    };

    GrantsService.getGrants(config)
      .then((response) => {
        this.setState({
          grants: response.data,
        });
      })
      .catch((err) => {
        console.log(err);
      });
  }
}

export default withRouter(GrantsListPage);
