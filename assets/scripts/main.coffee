
# Don't trust this algorithm
compareEngine = (yourName, matesName) ->
  you = yourName.split("").sort()
  friend = matesName.split("").sort()
  intersect = []
  if you.length > friend.length
    you.forEach (letter) ->
      if friend.indexOf(letter) != -1
        intersect.push letter
        return
  else
    friend.forEach (letter) ->
      if you.indexOf(letter) != -1
        intersect.push letter
        return

  score = ( intersect.length / (+you.length + friend.length) ) * 100
  return Math.ceil(100 - score - (+you.length + friend.length) )


Results = React.createClass
  render: ->
    score = this.props.score
    window.randomize = ->
      $(".radial-progress").attr("data-progress", score)
      return
    setTimeout(window.randomize, 200)
    <div className="results">
        <div className="radial-progress" data-progress="0">
        <div className="circle">
          <div className="mask full">
            <div className="fill"></div>
          </div>
          <div className="mask half">
            <div className="fill"></div>
            <div className="fill fix"></div>
          </div>
          <div className="shadow"></div>
        </div>
        <div className="inset">
          <div className="percentage">
            <div className="numbers"><span>-</span><span>0%</span><span>1%</span><span>2%</span><span>3%</span><span>4%</span><span>5%</span><span>6%</span><span>7%</span><span>8%</span><span>9%</span><span>10%</span><span>11%</span><span>12%</span><span>13%</span><span>14%</span><span>15%</span><span>16%</span><span>17%</span><span>18%</span><span>19%</span><span>20%</span><span>21%</span><span>22%</span><span>23%</span><span>24%</span><span>25%</span><span>26%</span><span>27%</span><span>28%</span><span>29%</span><span>30%</span><span>31%</span><span>32%</span><span>33%</span><span>34%</span><span>35%</span><span>36%</span><span>37%</span><span>38%</span><span>39%</span><span>40%</span><span>41%</span><span>42%</span><span>43%</span><span>44%</span><span>45%</span><span>46%</span><span>47%</span><span>48%</span><span>49%</span><span>50%</span><span>51%</span><span>52%</span><span>53%</span><span>54%</span><span>55%</span><span>56%</span><span>57%</span><span>58%</span><span>59%</span><span>60%</span><span>61%</span><span>62%</span><span>63%</span><span>64%</span><span>65%</span><span>66%</span><span>67%</span><span>68%</span><span>69%</span><span>70%</span><span>71%</span><span>72%</span><span>73%</span><span>74%</span><span>75%</span><span>76%</span><span>77%</span><span>78%</span><span>79%</span><span>80%</span><span>81%</span><span>82%</span><span>83%</span><span>84%</span><span>85%</span><span>86%</span><span>87%</span><span>88%</span><span>89%</span><span>90%</span><span>91%</span><span>92%</span><span>93%</span><span>94%</span><span>95%</span><span>96%</span><span>97%</span><span>98%</span><span>99%</span><span>100%</span></div>
          </div>
        </div>
        </div>
      </div>


Cupid = React.createClass
  getInitialState: ->
    return {yourName: "", matesName: "", showResults: false, score: 0, errorMessage: ""}

  handleyourNameChange: (e) ->
    this.setState({yourName: e.target.value})
    this.setState({showResults: false})
    this.setState({errorMessage: ""})
    return

  handleMatesNameChange: (e) ->
    this.setState({matesName: e.target.value})
    this.setState({showResults: false})
    this.setState({errorMessage: ""})

  handleSubmit: (e) ->
    e.preventDefault()
    yourName = this.state.yourName.trim()
    matesName = this.state.matesName.trim()

    # check for empty fields
    if yourName.length < 1
      this.setState({errorMessage: "Please enter your name"})
      return
    else if matesName.length < 1
      this.setState({errorMessage: "Please enter your friend's name"})
      return
    else
      result = compareEngine(yourName, matesName)
      this.setState({score: result})
      this.setState({showResults: true})
      return

  render: ->
    <form className="Cupid" onSubmit={this.handleSubmit}>
          <h1>Friendship Rating ¯\_(ツ)_/¯ </h1>
          <span className="error">{this.state.errorMessage}</span>
        <label htmlFor="your-name">
          <input className="input" autoComplete=false placeholder="Your name" onChange={this.handleyourNameChange} value={this.state.yourName} type="text" id="your-name" />
        </label>
        <span className="and"> and </span>
        <label htmlFor="mates-name">
          <input className="input" autoComplete=false placeholder="Your friends's name" onChange={this.handleMatesNameChange} value={this.state.matesName} type="text" id="mates-name" />
        </label>
        <button className="button" type="submit">check</button>
        { <Results score={this.state.score} /> if this.state.showResults }
    </form>

ReactDOM.render(<Cupid />, document.getElementById("container"))